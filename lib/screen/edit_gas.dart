import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class EditGasMenu extends StatefulWidget {
  final GasModel gasModel;

  EditGasMenu({Key key, this.gasModel}) : super(key: key);

  @override
  State<EditGasMenu> createState() => _EditGasMenuState();
}

class _EditGasMenuState extends State<EditGasMenu> {
  GasModel gasModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasModel = widget.gasModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไข รายการแก๊ส ${gasModel.brandGas}'),
      ),
      body: Column(
        children: <Widget>[
          brandGas(),
          MyStyle().mySizebox(),
          priceGas(),
          MyStyle().mySizebox(),
          qtyGas(),
        ],
      ),
    );
  }

  Widget brandGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              initialValue: gasModel.brandGas,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อแก๊ส',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget priceGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              initialValue: gasModel.price,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อแก๊ส',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget qtyGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              initialValue: gasModel.quantity,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อแก๊ส',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
