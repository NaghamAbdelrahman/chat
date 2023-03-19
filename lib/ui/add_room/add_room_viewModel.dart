import 'package:chat/base/base_viewModel.dart';
import 'package:chat/datebase/my_dataBase.dart';
import 'package:chat/model/room.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String name, String categoryId, String description) async {
    navigator?.showProgressDialog('Creating Room...', isDismisable: false);
    try {
      await MyDataBase.createRoom(
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
