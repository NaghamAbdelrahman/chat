import 'package:chat/domain/repository/rooms_repository_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/room.dart';

class RoomsRepositoryImpl implements RoomsRepository {
  RoomsFireBaseDataSource dataSource;

  RoomsRepositoryImpl(this.dataSource);

  @override
  Future<void> createRoom(Room room) {
    return dataSource.createRoom(room);
  }

  @override
  Stream<QuerySnapshot<Room>> loadRooms() {
    return dataSource.loadRooms();
  }
}
