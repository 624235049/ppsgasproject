import 'package:flutter/material.dart';

class AddGasMenu extends StatefulWidget {
  @override
  State<AddGasMenu> createState() => _AddGasMenuState();
}

class _AddGasMenuState extends State<AddGasMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการแก๊ส'),
      ),
    );
  }
}
