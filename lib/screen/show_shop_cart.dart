import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/cart_model.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:ppsgasproject/utility/sqlite_helper.dart';

class ShowCart extends StatefulWidget {
  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<CartModel> cartModels = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    var object = await SQLiteHelper().readAllDataFormSQLite();
    setState(() {
      cartModels = object;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
      ),
      body: cartModels.length == 0 ? MyStyle().showProgress() : buildlistGas(),
    );
  }

  Widget buildlistGas() => ListView.builder(
        itemCount: cartModels.length,
        itemBuilder: (context, index) => Text(cartModels[index].gas_brand_name),
      );
}
