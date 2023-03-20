import 'package:chat/data/datasource/auth_dataSource_impl.dart';
import 'package:chat/data/datasource/messages_dataSource_impl.dart';
import 'package:chat/data/datasource/rooms_dataSource_impl.dart';
import 'package:chat/data/datebase/my_dataBase.dart';
import 'package:chat/data/repository/auth_repository_impl.dart';
import 'package:chat/data/repository/messages_repository_impl.dart';
import 'package:chat/data/repository/rooms_repository_impl.dart';
import 'package:chat/domain/repository/auth_repository_contract.dart';
import 'package:chat/domain/repository/messages_repository_contract.dart';
import 'package:chat/domain/repository/rooms_repository_contract.dart';

MyDataBase getDataBase() {
  return MyDataBase();
}

AuthFireBaseDataSource injectAuthDataSource() {
  return AuthFireBaseDataSourceImpl(getDataBase());
}

AuthRepository injectAuthRepository() {
  return AuthRepositoryImpl(injectAuthDataSource());
}

RoomsFireBaseDataSource injectRoomDataSource() {
  return RoomsFireBaseDataSourceImpl(getDataBase());
}

RoomsRepository injectRoomsRepository() {
  return RoomsRepositoryImpl(injectRoomDataSource());
}

MessagesFireBaseDataSource injectMessageDataSource() {
  return MessagesFireBaseDataSourceImpl(getDataBase());
}

MessagesRepository injectMessagesRepository() {
  return MessagesRepositoryImpl(injectMessageDataSource());
}
