import 'package:chat/domain/repository/rooms_repository_contract.dart';

import '../../domain/model/room.dart';
import '../base/base_viewModel.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  RoomsRepository repository;

  AddRoomViewModel(this.repository);

  void addRoom(String name, String categoryId, String description) async {
    navigator?.showProgressDialog('Creating Room...', isDismisable: false);
    try {
      await repository.createRoom(
          Room(name: name, description: description, catId: categoryId));
      navigator?.hideDialog();

      navigator?.showMessageDialog('Room created successfully',
          isDismisable: false, posActionTittle: 'ok', posAction: () {
        navigator?.goBack();
      });
    } catch (error) {
      navigator?.showMessageDialog('Something went wrong, ${error.toString()} ',
          posActionTittle: 'Try Again', isDismisable: false);
    }
  }
}

abstract class AddRoomNavigator extends BaseNavigator {
  void goBack();
}
