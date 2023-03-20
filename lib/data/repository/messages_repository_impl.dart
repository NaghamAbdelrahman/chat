import 'package:chat/domain/repository/messages_repository_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/message.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  MessagesFireBaseDataSource dataSource;

  MessagesRepositoryImpl(this.dataSource);

  @override
  Stream<QuerySnapshot<Message>> getMessages(String roomId) {
    return dataSource.getMessages(roomId);
  }

  @override
  Future<void> sendMessage(String roomId, Message message) {
    return dataSource.sendMessage(roomId, message);
  }
}
