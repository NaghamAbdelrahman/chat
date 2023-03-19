import 'package:chat/base/base_viewModel.dart';
import 'package:chat/datebase/my_dataBase.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/room.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  Stream<QuerySnapshot<Room>> loadRooms() {
    return MyDataBase.getRoomCollection().snapshots();
  }

  void logOut() {
    navigator?.showMessageDialog('Are you sure you want to logout !',
        posActionTittle: 'Ok', posAction: () {
      FirebaseAuth.instance.signOut();
      navigator?.goToLoginPage(LoginScreen.routeName);
    }, negActionTittle: 'Cancel', isDismisable: false);
  }
}

abstract class HomeNavigator extends BaseNavigator {
  goToLoginPage(String routeName);
}
