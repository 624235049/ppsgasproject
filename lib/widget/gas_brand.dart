import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/screen/add_brand_gas.dart';
import 'package:ppsgasproject/screen/edit_brand_gas.dart';
import 'package:ppsgasproject/screen/edit_gas.dart';

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

  List<GasBrandModel> gasbrandModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readBrandGasShop();
  }

  Future<Null> readBrandGasShop() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String idtype = preferences.getString('id');
    if (gasbrandModels.length != 0) {
      gasbrandModels.clear();
    }

    String url = '${MyConstant().domain}/gas/gasbrand.php';

    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      // print('value ==> $value');
      var result = json.decode(value.data);
      // print('result ==> $result');

      for (var item in result) {
        // print('item ==> $item');
        GasBrandModel model = GasBrandModel.fromJson(item);
        // print('brand gas ==>> ${model.brandGas}');

        setState(() {
          gasbrandModels.add(model);
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
        itemCount: gasbrandModels.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Image.network(
                  '${MyConstant().domain}${gasbrandModels[index].gas_brand_image}'),
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
                      'ID : ${gasbrandModels[index].gas_brand_id} ',
                      style: MyStyle().mainTitle,
                    ),
                    Text(
                      'ยี่ห้อ ${gasbrandModels[index].gas_brand_name} ',
                      style: MyStyle().mainh2Title,
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
                              builder: (context) => EditBrandGas(
                                gasbrandModel: gasbrandModels[index],
                              ),
                            );
                            Navigator.push(context, route).then(
                              (value) => readBrandGasShop(),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => deleteGas(gasbrandModels[index]),
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
                      builder: (context) => AddBrandGasMenu(),
                    );
                    Navigator.push(context, route).then(
                      (value) => readBrandGasShop(),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );

  Future<Null> deleteGas(GasBrandModel gasbrandModels) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2(
            'คุณต้องการลบ รายการแก๊ส ${gasbrandModels.gas_brand_name} ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyConstant().domain}/gas/deletebrandWhereid.php?isAdd=true&gas_brand_id=${gasbrandModels.gas_brand_id}';
                  await Dio().get(url).then((value) => readBrandGasShop());
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
}


// Container(
//       padding: EdgeInsets.all(10.0),
//       child: Scaffold(
//         body: loadStatus
//             ? MyStyle().showProgress()
//             : GridView.builder(
//                 itemCount: gastypeModel.length,
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 260),
//                 itemBuilder: (context, index) => Column(children: <Widget>[
//                   Container(
//                     child: TextFormField(
//                       initialValue: gastypeModel[index].gas_brand_id,
//                       style: MyStyle().mainh2Title,
//                     ),
//                   ),
//                   Container(
//                     child: TextFormField(
//                       initialValue: gastypeModel[index].gas_brand_name,
//                       style: MyStyle().mainh2Title,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.amber,
//                         ),
//                         onPressed: () => {},
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ),
//                         onPressed: () => {},
//                       ),
//                     ],
//                   ),
//                 ]),
//               ),
//       ),