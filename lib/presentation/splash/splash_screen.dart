import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/sharedData/user_provider.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = 'splash';
  late var userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, routeNamePage());
    });
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  String routeNamePage() {
    return userProvider.fireBaseUser == null
        ? LoginScreen.routeName
        : HomeScreen.routeName;
  }
}
