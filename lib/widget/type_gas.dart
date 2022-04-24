import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/model/gas_type_model.dart';

import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeGasShop extends StatefulWidget {
  @override
  State<TypeGasShop> createState() => _TypeGasShopState();
}

class _TypeGasShopState extends State<TypeGasShop> {
  bool loadStatus = true; // Process load JSON
  bool status = true; // Have Data
  // GasTypeModel gasTypeModel;
  // GasModel gasModel;

  List<GasTypeModel> gastypeModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTypeGasShop();
  }

  Future<Null> readTypeGasShop() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String idtype = preferences.getString('id');

    String url = '${MyConstant().domain}/gasorderuser/gettypeWhereidtype.php';

    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      // print('value ==> $value');
      var result = json.decode(value.data);
      // print('result ==> $result');

      for (var item in result) {
        print('item ==> $item');
        GasTypeModel model = GasTypeModel.fromJson(item);
        // print('brand gas ==>> ${model.brandGas}');

        setState(() {
          gastypeModel.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Scaffold(
        body: loadStatus
            ? MyStyle().showProgress()
            : GridView.builder(
                itemCount: gastypeModel.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 260),
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                      child: TextFormField(
                        initialValue: gastypeModel[index].id,
                        style: MyStyle().mainh2Title,
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        initialValue: gastypeModel[index].brandGas,
                        style: MyStyle().mainh2Title,
                      ),
                    ),
                    ElevatedButton(
                      child: Text('บันทึก'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
