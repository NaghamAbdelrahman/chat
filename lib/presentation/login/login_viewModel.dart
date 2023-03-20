import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/model/my_user.dart';
import '../../domain/repository/auth_repository_contract.dart';
import '../base/base_viewModel.dart';
import '../home/home_screen.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var authService = FirebaseAuth.instance;
  AuthRepository authRepository;

  LoginViewModel(this.authRepository);

  void login(String email, String password) async {
    navigator?.showProgressDialog('Loading', isDismisable: false);
    try {
      final credential = await authService.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
          await authRepository.login(credential.user?.uid ?? '');
      navigator?.hideDialog();
      if (retrievedUser != null) {
        navigator?.goToHome(HomeScreen.routeName, retrievedUser);
      } else {
        navigator?.showMessageDialog(
            'something went wrong, Wrong email or password',
            posActionTittle: 'TryAgain',
            isDismisable: false);
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideDialog();
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        navigator?.showMessageDialog('Wrong email or password',
            posActionTittle: 'TryAgain', isDismisable: false);
      } else {
        navigator?.showMessageDialog('Please check internet connection',
            posActionTittle: 'Ok', isDismisable: false);
      }
    }
  }
}

abstract class LoginNavigator extends BaseNavigator {
  goToHome(String routeName, MyUser user);
}
