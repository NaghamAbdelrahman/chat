import 'package:chat/base/base_viewModel.dart';
import 'package:chat/datebase/my_dataBase.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var authService = FirebaseAuth.instance;

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
      var insertedUser = await MyDataBase.insertUser(newUser);
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
    } catch (e) {
      navigator?.showMessageDialog(
          'Some thing went wrong, please try again later',
          posActionTittle: 'Ok',
          isDismisable: false);
    }
  }
}

abstract class RegisterNavigator extends BaseNavigator {
  goToHome(String routeName, MyUser user);
}
