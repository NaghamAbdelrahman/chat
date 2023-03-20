import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';

abstract class MessagesFireBaseDataSource {
  Future<void> sendMessage(String roomId, Message message);

  Stream<QuerySnapshot<Message>> getMessages(String roomId);
}

abstract class MessagesRepository {
  Future<void> sendMessage(String roomId, Message message);

  Stream<QuerySnapshot<Message>> getMessages(String roomId);
}
