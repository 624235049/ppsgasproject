import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/screen/add_gas_menu.dart';
import 'package:ppsgasproject/screen/edit_gas.dart';
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
    String gas_id = preferences.getString('gas_id');
    // print('idShop = $idShop');

    String url = '${MyConstant().domain}/gas/gas.php';
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
        MyStyle().backlogo(),
        loadStatus ? MyStyle().showProgress() : showContent(),
        addGasButton(),
        // new Center(
        //   child: new ClipRect(
        //     child: new BackdropFilter(
        //       filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //       child: new Container(
        //         width: 200.0,
        //         height: 200.0,
        //         decoration: new BoxDecoration(
        //           color: Colors.grey.shade100.withOpacity(0.5),

        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Container(
        //   height: 600,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/splash_logo.png'),
        //       colorFilter: ColorFilter.mode(
        //           Colors.white.withOpacity(0.8), BlendMode.modulate),
        //     ),
        //   ),
        // ),
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
                  '${MyConstant().domain}${gasmodels[index].path_image}'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      gasmodels[index].gas_brand_id,
                      style: MyStyle().mainTitle,
                    ),
                    Text(
                      'ราคา ${gasmodels[index].price} บาท',
                      style: MyStyle().mainh2Title,
                    ),
                    Text(
                      'ขนาด ${gasmodels[index].gas_size_id} กิโลกรัม',
                      style: MyStyle().mainh2Title,
                    ),
                    Text(
                      'จำนวน ${gasmodels[index].quantity} ถัง',
                      style: MyStyle().mainh3Title,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => EditGasMenu(
                                gasModel: gasmodels[index],
                              ),
                            );
                            Navigator.push(context, route).then(
                              (value) => readGasMenu(),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => deleteGas(gasmodels[index]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Future<Null> deleteGas(GasModel gasModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle()
            .showTitleH2('คุณต้องการลบ รายการแก๊ส ${gasModel.gas_brand_id} ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyConstant().domain}/gas/deleteGasWhereid.php?isAdd=true&gas_id=${gasModel.gas_id}';
                  await Dio().get(url).then((value) => readGasMenu());
                },
                child: Text('ยืนยัน'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              ),
            ],
          )
        ],
      ),
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
