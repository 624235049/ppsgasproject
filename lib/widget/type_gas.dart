import 'package:flutter/material.dart';

class TypeGasShop extends StatefulWidget {
  @override
  State<TypeGasShop> createState() => _TypeGasShopState();
}

class _TypeGasShopState extends State<TypeGasShop> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'จัดการประเภทแก๊ส',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _formTypeGas(),
          ],
        ),
      ),
    );
  }

  _formTypeGas() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formkey,
          child: Column(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'ประเภทแก๊ส'),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {},
                child: Text('submit'),
                color: Colors.red,
                textColor: Colors.white,
              ),
            )
          ]),
        ),
      );
}
