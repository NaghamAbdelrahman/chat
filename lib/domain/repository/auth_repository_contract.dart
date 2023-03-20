import '../model/my_user.dart';

abstract class AuthFireBaseDataSource {
  Future<MyUser?> register(MyUser user);

  Future<MyUser?> login(String userId);
}

abstract class AuthRepository {
  Future<MyUser?> register(MyUser user);

  Future<MyUser?> login(String userId);
}
