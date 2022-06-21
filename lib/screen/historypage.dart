import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'History Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
