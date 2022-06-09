import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';

class EditBrandGas extends StatefulWidget {
  final GasBrandModel gasbrandmodel;

  EditBrandGas({Key key, this.gasbrandmodel}) : super(key: key);

  @override
  State<EditBrandGas> createState() => _EditBrandGasState();
}

class _EditBrandGasState extends State<EditBrandGas> {
  GasBrandModel gasBrandModel;
  File file;
  String gas_brand_id, gas_brand_name, gas_brand_image;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
