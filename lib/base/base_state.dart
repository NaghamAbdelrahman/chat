import 'package:flutter/material.dart';

import '../ui/utils/dialog_utils.dart';
import 'base_viewModel.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void hideDialog() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showMessageDialog(String message,
      {String? posActionTittle,
      String? negActionTittle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isDismisable = true}) {
    DialogUtils.showMessageDialog(context, message,
        posActionTittle: posActionTittle,
        isDismisable: isDismisable,
        posAction: posAction,
        negActionTittle: negActionTittle,
        negAction: negAction);
  }

  @override
  void showProgressDialog(String message, {bool isDismisable = true}) {
    DialogUtils.showProgressDialog(context, message,
        isDismisable: isDismisable);
  }
}
