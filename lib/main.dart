import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.red),
      title: 'PPT Gas',
      home: HomePage(),
    );
  }
}
