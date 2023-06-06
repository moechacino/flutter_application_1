import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/member_home_TRI21.dart';
import "src/screens/welcome_screens.dart";
import 'package:get/get.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/register_screen.dart';
import 'src/screens/member_home_TRI21.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
