import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/message.dart';
import '../../domain/model/my_user.dart';
import '../../domain/model/room.dart';

class MyDataBase {
  CollectionReference<MyUser> getUsersCollection() {
    var userCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, _) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, option) => user.toFireStore());
    return userCollection;
  }

  Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    await docRef.set(user);
    return user;
  }

  Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  CollectionReference<Room> getRoomCollection() {
    var userCollection = FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, _) =>
                Room.fromFireStore(snapshot.data()!),
            toFirestore: (room, option) => room.toFireStore());
    return userCollection;
  }

  Future<void> createRoom(Room room) async {
    var collection = getRoomCollection();
    var docRef = collection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                Message.fromFireStore(snapshot.data()!),
            toFirestore: (message, options) => message.toFireStore());
  }

  Future<void> sendMessage(String roomId, Message message) {
    var docRef = getMessageCollection(roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  Stream<QuerySnapshot<Message>> getMessages(String roomId) {
    return getMessageCollection(roomId)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
