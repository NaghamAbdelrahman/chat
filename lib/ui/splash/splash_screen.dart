import 'dart:async';

import 'package:chat/providers/user_provider.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
