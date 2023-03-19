import 'package:chat/base/base_viewModel.dart';
import 'package:chat/datebase/my_dataBase.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  MyUser? user;

  void send(String messageContent) {
    if (messageContent.trim().isEmpty) {
      return;
    }
    Message message = Message(
      content: messageContent,
      senderId: user?.id,
      senderName: user?.fullName,
      roomId: room.id,
      dateTime: DateTime.now().microsecondsSinceEpoch,
    );
    MyDataBase.sendMessage(room.id!, message).then((value) {
      navigator?.clearMessageText();
    }).onError((error, stackTrace) {
      navigator?.showMessageDialog('something went wrong',
          posActionTittle: 'Try Again', posAction: () {
        send(messageContent);
      }, negActionTittle: 'Cancel', isDismisable: false);
    });
  }

  Stream<QuerySnapshot<Message>> getMessagesRealTime() {
    return MyDataBase.getMessageCollection(room.id ?? '')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void clearMessageText();
}
