import 'package:chat/data/datebase/my_dataBase.dart';
import 'package:chat/domain/repository/messages_repository_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/message.dart';

class MessagesFireBaseDataSourceImpl implements MessagesFireBaseDataSource {
  MyDataBase dataBase;

  MessagesFireBaseDataSourceImpl(this.dataBase);

  @override
  Future<void> sendMessage(String roomId, Message message) {
    return dataBase.sendMessage(roomId, message);
  }

  @override
  Stream<QuerySnapshot<Message>> getMessages(String roomId) {
    return dataBase
        .getMessageCollection(roomId)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
