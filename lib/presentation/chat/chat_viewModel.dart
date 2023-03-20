import 'package:chat/domain/repository/messages_repository_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/message.dart';
import '../../domain/model/my_user.dart';
import '../../domain/model/room.dart';
import '../base/base_viewModel.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  MyUser? user;
  MessagesRepository repository;

  ChatViewModel(this.repository);

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
    repository.sendMessage(room.id!, message).then((value) {
      navigator?.clearMessageText();
    }).onError((error, stackTrace) {
      navigator?.showMessageDialog('something went wrong',
          posActionTittle: 'Try Again', posAction: () {
        send(messageContent);
      }, negActionTittle: 'Cancel', isDismisable: false);
    });
  }

  Stream<QuerySnapshot<Message>> getMessagesRealTime() {
    return repository.getMessages(room.id ?? '');
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void clearMessageText();
}
