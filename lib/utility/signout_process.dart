import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> signOutProcess(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  // exit(0);

  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => HomePage(),
  );
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
