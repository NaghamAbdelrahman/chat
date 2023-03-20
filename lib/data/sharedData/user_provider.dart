import 'package:chat/data/datasource/auth_dataSource_impl.dart';
import 'package:chat/data/repository/auth_repository_impl.dart';
import 'package:chat/domain/repository/auth_repository_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/model/my_user.dart';
import '../datebase/my_dataBase.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  User? fireBaseUser;
  late MyDataBase dataBase;
  late AuthFireBaseDataSource dataSource;
  late AuthRepository repository;

  UserProvider() {
    dataBase = MyDataBase();
    dataSource = AuthFireBaseDataSourceImpl(dataBase);
    repository = AuthRepositoryImpl(dataSource);
    fireBaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  void initUser() async {
    if (fireBaseUser != null) {
      user = await repository.login(fireBaseUser?.uid ?? '');
    }
  }
}
