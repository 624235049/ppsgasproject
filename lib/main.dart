import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/home.dart';

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
      home: HomePage(),
    );
  }
}
