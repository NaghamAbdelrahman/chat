import 'package:chat/domain/repository/auth_repository_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/model/my_user.dart';
import '../base/base_viewModel.dart';
import '../home/home_screen.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var authService = FirebaseAuth.instance;
  AuthRepository authRepository;

  RegisterViewModel(this.authRepository);

  void register(String email, String password, String name) async {
    navigator?.showProgressDialog('Loading...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser newUser = MyUser(
        id: credential.user?.uid,
        fullName: name,
        email: email,
      );
      var insertedUser = await authRepository.register(newUser);
      navigator?.hideDialog();
      if (insertedUser != null) {
        navigator?.goToHome(HomeScreen.routeName, insertedUser);
      } else {
        navigator?.showMessageDialog(
            'Some thing went wrong, error with data base',
            posActionTittle: 'Try Again',
            isDismisable: false);
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('The password provided is too weak.',
            posActionTittle: 'Try Again', isDismisable: false);
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog(
            'The account already exists for that email.',
            posActionTittle: 'Try Again',
            isDismisable: false);
      } else if (e.code == 'network-request-failed') {
        navigator?.showMessageDialog('Please check internet connection',
            posActionTittle: 'Ok', isDismisable: false);
      }
    }
  }
}

abstract class RegisterNavigator extends BaseNavigator {
  goToHome(String routeName, MyUser user);
}
