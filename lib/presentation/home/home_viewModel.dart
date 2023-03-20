import 'package:chat/domain/repository/rooms_repository_contract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/model/room.dart';
import '../base/base_viewModel.dart';
import '../login/login_screen.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  RoomsRepository repository;

  HomeViewModel(this.repository);

  Stream<QuerySnapshot<Room>> loadRooms() {
    return repository.loadRooms();
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
