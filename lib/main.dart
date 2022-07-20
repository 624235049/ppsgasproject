import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/historypage.dart';
import 'package:ppsgasproject/screen/home.dart';
import 'package:ppsgasproject/screen/main_user.dart';
import 'package:ppsgasproject/screen/profilepage.dart';
import 'package:ppsgasproject/screen/splash_screen.dart';
import 'package:ppsgasproject/screen/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(HomePage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      title: 'PPS Gas',
      // home: HomePage(),

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        // '/home': (context) => Hometab(),
        'home_tab': (context) => HomePage(),
      },
    );
  }
}
