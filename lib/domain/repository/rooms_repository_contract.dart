import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/room.dart';

abstract class RoomsFireBaseDataSource {
  Future<void> createRoom(Room room);

  Stream<QuerySnapshot<Room>> loadRooms();
}

abstract class RoomsRepository {
  Future<void> createRoom(Room room);

  Stream<QuerySnapshot<Room>> loadRooms();
}
