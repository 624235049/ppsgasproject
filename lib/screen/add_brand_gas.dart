import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';

class AddBrandGasMenu extends StatefulWidget {
  final GasBrandModel gasBrandModels;
  AddBrandGasMenu({Key key, this.gasBrandModels}) : super(key: key);
  @override
  State<AddBrandGasMenu> createState() => _AddBrandGasMenuState();
}

class _AddBrandGasMenuState extends State<AddBrandGasMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
