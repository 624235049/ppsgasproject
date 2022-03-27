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
    if (gasmodels.length != 0) {
      gasmodels.clear();
    }

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
        // print('value ==> $value');
        var result = json.decode(value.data);
        // print('result ==> $result');

        for (var map in result) {
          GasModel gasModel = GasModel.fromJson(map);
          setState(() {
            gasmodels.add(gasModel);
          });
        }
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
        ? showListGas()
        : Center(
            child: Text('ยังไม่มีรายการแก๊ส'),
          );
  }

  Widget showListGas() => ListView.builder(
        itemCount: gasmodels.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Image.network(
                  '${MyConstant().domain}${gasmodels[index].pathImage}'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    gasmodels[index].brandGas,
                    style: MyStyle().mainTitle,
                  ),
                  Text(
                    'ราคา ${gasmodels[index].price} บาท',
                    style: MyStyle().mainh2Title,
                  ),
                  Text(
                    'ขนาด ${gasmodels[index].size} kg',
                    style: MyStyle().mainh3Title,
                  ),
                  Text(
                    'จำนวน ${gasmodels[index].quantity} ถัง',
                    style: MyStyle().mainh3Title,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

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
                    Navigator.push(context, route)
                        .then((value) => readGasMenu());
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}
