import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/MyHomePage.dart';
import 'screens/SplashScreenInitial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenInitial(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (context) => MyHomePage(),
      },
    );
  }
}
