import 'package:chat/datebase/my_dataBase.dart';
import 'package:chat/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  User? fireBaseUser;

  UserProvider() {
    fireBaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  void initUser() async {
    if (fireBaseUser != null) {
      user = await MyDataBase.getUserById(fireBaseUser?.uid ?? '');
    }
  }
}
