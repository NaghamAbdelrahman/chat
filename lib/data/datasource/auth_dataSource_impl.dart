import 'package:chat/data/datebase/my_dataBase.dart';
import 'package:chat/domain/repository/auth_repository_contract.dart';

import '../../domain/model/my_user.dart';

class AuthFireBaseDataSourceImpl implements AuthFireBaseDataSource {
  MyDataBase dataBase = MyDataBase();

  AuthFireBaseDataSourceImpl(this.dataBase);

  @override
  Future<MyUser?> login(String userId) async {
    var user = await dataBase.getUserById(userId);
    return MyUser.toDomainUser(user!);
  }

  @override
  Future<MyUser?> register(MyUser user) async {
    var newUser = await dataBase.insertUser(user);
    return MyUser.toDomainUser(newUser!);
  }
}
