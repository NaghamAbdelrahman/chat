import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void hideDialog();

  void showProgressDialog(String message, {bool isDismisable = true});

  void showMessageDialog(String message,
      {String? posActionTittle,
      String? negActionTittle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismisable = true});
}

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}
