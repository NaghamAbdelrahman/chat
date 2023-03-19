import 'package:chat/base/base_state.dart';
import 'package:chat/ui/chat/chat_viewModel.dart';
import 'package:chat/ui/chat/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';
import '../../model/room.dart';
import '../../providers/user_provider.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = 'chat-thread';

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatViewModel>
    implements ChatNavigator {
  late Room room;
  var messageController = TextEditingController();

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.user = userProvider.user;
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
            appBar: AppBar(
              title: Center(child: Text(room.name ?? '')),
            ),
            body: Card(
              elevation: 12,
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.getMessagesRealTime(),
                    builder: (buildContext, asyncSnapShot) {
                      if (asyncSnapShot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      } else if (asyncSnapShot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data = asyncSnapShot.data?.docs
                          .map((doc) => doc.data())
                          .toList();
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                            reverse: true,
                            separatorBuilder: (_, __) {
                              return const SizedBox(height: 10);
                            },
                            itemBuilder: (buildContext, index) {
                              return MessageWidget(data![index]);
                            },
                            itemCount: data?.length ?? 0),
                      );
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type a message',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              enabled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.send(messageController.text);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: const [
                                Icon(Icons.send, color: Colors.white),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void clearMessageText() {
    messageController.clear();
  }
}
