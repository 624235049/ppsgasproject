import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/home.dart';
import 'package:ppsgasproject/screen/splash_screen.dart';

void main() {
  runApp(MyApp());
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
        '/home': (context) => HomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTabIndex = 0;
  String titleApp = 'HOME';
  String userId = '';
  List<Widget> tabs = [
    HomePage(),
  ];
//on tap tabs
  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
      if (currentTabIndex == 0) {
        titleApp = 'HOME';
      } else if (currentTabIndex == 1) {
        titleApp = 'HISTORY';
      } else if (currentTabIndex == 2) {
        titleApp = 'NOTIFICATIONS';
      } else if (currentTabIndex == 3) {
        titleApp = 'PROFILE';
      } else {
        titleApp = 'MY GAS';
      }
    });
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      title: Text(
        titleApp,
      ),
      automaticallyImplyLeading: false,
    );
  }
}
