import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/screen/add_gas_menu.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListGasShop extends StatefulWidget {
  @override
  _ListGasShopState createState() => _ListGasShopState();
}

class _ListGasShopState extends State<ListGasShop> {
  bool loadStatus = true; // Process load JSON
  bool status = true; // Have Data
  
  List<GasModel> gasmodels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readGasMenu();
  }

  Future<Null> readGasMenu() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');
    print('idShop = $idShop');

    String url =
        '${MyConstant().domain}/gasorderuser/getGasWhereidShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        print('value ==> $value');
        var result = json.decode(value.data);
        print('result ==> $result');
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadStatus ? MyStyle().showProgress() : showContent(),
        addGasButton(),
      ],
    );
  }

  Widget showContent() {
    return status
        ? Text('รายการแก๊สของร้านที่นี่')
        : Center(
            child: Text('ยังไม่มีรายการแก๊ส'),
          );
  }

  Widget addGasButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddGasMenu(),
                    );
                    Navigator.push(context, route);
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}
