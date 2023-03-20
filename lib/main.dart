import 'package:chat/presentation/add_room/add_room_screen.dart';
import 'package:chat/presentation/chat/chat_thread.dart';
import 'package:chat/presentation/home/home_screen.dart';
import 'package:chat/presentation/login/login_screen.dart';
import 'package:chat/presentation/registeration/register_screen.dart';
import 'package:chat/presentation/splash/splash_screen.dart';
import 'package:chat/presentation/style/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/sharedData/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (_) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: MyTheme.appTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        AddRoomScreen.routeName: (_) => AddRoomScreen(),
        ChatThread.routeName: (_) => ChatThread()
      },
    );
  }
}
