import 'package:chat/domain/repository/auth_repository_contract.dart';

import '../../domain/model/my_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthFireBaseDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<MyUser?> login(String userId) {
    return dataSource.login(userId);
  }

  @override
  Future<MyUser?> register(MyUser user) {
    return dataSource.register(user);
  }
}
