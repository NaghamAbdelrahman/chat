import 'package:chat/my_theme.dart';
import 'package:chat/providers/user_provider.dart';
import 'package:chat/ui/add_room/add_room_screen.dart';
import 'package:chat/ui/chat/chat_thread.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/registeration/register_screen.dart';
import 'package:chat/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
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
