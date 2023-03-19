import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUsersCollection() {
    var userCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, _) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, option) => user.toFireStore());
    return userCollection;
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static CollectionReference<Room> getRoomCollection() {
    var userCollection = FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, _) =>
                Room.fromFireStore(snapshot.data()!),
            toFirestore: (room, option) => room.toFireStore());
    return userCollection;
  }

  static Future<void> createRoom(Room room) async {
    var collection = getRoomCollection();
    var docRef = collection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRooms() async {
    var querySnapshots = await getRoomCollection().get();
    var roomList = querySnapshots.docs
        .map((queryDocSnapshot) => queryDocSnapshot.data())
        .toList();
    return roomList;
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                Message.fromFireStore(snapshot.data()!),
            toFirestore: (message, options) => message.toFireStore());
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var docRef = getMessageCollection(roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }
}
