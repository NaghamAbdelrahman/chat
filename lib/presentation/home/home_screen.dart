import 'package:chat/app/dependency_injection.dart';
import 'package:chat/presentation/home/room_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/room.dart';
import '../add_room/add_room_screen.dart';
import '../base/base_state.dart';
import 'home_viewModel.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel(injectRoomsRepository());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Center(child: Text('Chat')),
              actions: [
                IconButton(
                    onPressed: () {
                      viewModel.logOut();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.routeName);
              },
              child: const Icon(Icons.add),
            ),
            body: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Room>>(
                        stream: viewModel.loadRooms(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var data = snapshot.data?.docs
                              .map((doc) => doc.data())
                              .toList();
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (buildContext, index) {
                              return RoomWidget(data![index]);
                            },
                            itemCount: data?.length,
                          );
                        }))
              ],
            )),
      ),
    );
  }

  @override
  goToLoginPage(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
/*
Consumer<HomeViewModel>(
                    builder: (_,homeViewModel,__){
                      return (homeViewModel.room.isEmpty)?const Center(child: Text('No rooms joined yet'))
                          :GridView.builder(
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        )
                        , itemBuilder: (buildContext,index){
                          return RoomWidget(homeViewModel.room[index]);
                      },itemCount: homeViewModel.room.length,);
                    },
                  ),
 */
