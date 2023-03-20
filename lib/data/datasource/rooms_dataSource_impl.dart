import 'package:chat/data/datebase/my_dataBase.dart';
import 'package:chat/domain/repository/rooms_repository_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/room.dart';

class RoomsFireBaseDataSourceImpl implements RoomsFireBaseDataSource {
  MyDataBase dataBase;

  RoomsFireBaseDataSourceImpl(this.dataBase);

  @override
  Future<void> createRoom(Room room) async {
    var newRoom = await dataBase.createRoom(room);
    return newRoom;
  }

  @override
  Stream<QuerySnapshot<Room>> loadRooms() {
    return dataBase.getRoomCollection().snapshots();
  }
}
