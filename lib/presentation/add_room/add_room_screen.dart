import 'package:chat/app/dependency_injection.dart';
import 'package:chat/presentation/add_room/add_room_viewModel.dart';
import 'package:chat/presentation/reusable/button_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/room_category.dart';
import '../base/base_state.dart';

class AddRoomScreen extends StatefulWidget {
  static const routeName = 'addRoom';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  List<RoomCategory> cats = RoomCategory.getRoomCategories();
  late RoomCategory selectedCategory;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = cats[0];
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel(injectRoomsRepository());
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
            title: const Center(child: Text('Add Room')),
          ),
          body: Card(
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create New Room',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset('assets/images/add_room_image.png'),
                    TextFormField(
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter room name';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Enter Room Name'),
                    ),
                    DropdownButton<RoomCategory>(
                        value: selectedCategory,
                        items: cats.map((cat) {
                          return DropdownMenuItem<RoomCategory>(
                              value: cat,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/${cat.id}.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                  Text(cat.name),
                                ],
                              ));
                        }).toList(),
                        onChanged: (item) {
                          if (item == null) return;
                          selectedCategory = item;
                          setState(() {});
                        }),
                    TextFormField(
                      controller: descController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter room description';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Enter Room Description'),
                      maxLines: 3,
                      minLines: 3,
                    ),
                    const SizedBox(height: 10),
                    FormButton(text: 'Create', onPressed: submit),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.addRoom(
        nameController.text, selectedCategory.id, descController.text);
  }

  @override
  void goBack() {
    Navigator.pop(context);
  }
}
