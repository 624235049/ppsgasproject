import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';

class ShowShopGasMenu extends StatefulWidget {
  final GasBrandModel gasBrandModels;
  ShowShopGasMenu({Key key, this.gasBrandModels}) : super(key: key);
  @override
  State<ShowShopGasMenu> createState() => _ShowShopGasMenuState();
}

class _ShowShopGasMenuState extends State<ShowShopGasMenu> {
  GasBrandModel gasBrandModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasBrandModels = widget.gasBrandModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gasBrandModels.gas_brand_name),
      ),
    );
  }
}
