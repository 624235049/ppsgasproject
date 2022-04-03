import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_model.dart';

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
    );
  }
}
