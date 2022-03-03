import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';
import 'package:ppsgasproject/screen/add_detail_shop.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailShop extends StatefulWidget {
  String get id => null;

  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  DetailShopModel detailShopModel;

  @override
  void initState() {
    super.initState();
    readDataShop();
  }

  Future<Null> readDataShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url =
        '${MyConstant().domain}/gasorderuser/getdetailShop.php?isAdd=true&id=2';
    await Dio().get(url).then((value) {
      print('value = $value');
      var result = json.decode(value.data);
      print('result = $result');
      for (var map in result) {
        setState(() {
          detailShopModel = DetailShopModel.fromJson(map);
        });
        print('nameShop = ${detailShopModel.nameShop}');
      }
    });
  }

  void routeToAddDetail() {
    print('routeToAddDetail Work');
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddDetailShop(),
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        detailShopModel == null
            ? MyStyle().showProgress()
            : detailShopModel.nameShop.isEmpty
                ? showNoData(context)
                : Text('Have Data'),
        addEditButton(),
      ],
    );
  }

  Widget showNoData(BuildContext context) =>
      MyStyle().titleCenter(context, 'ยังไม่มีข้อมูลกรุณาเพิ่มด้วยค่ะ');

  Row addEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  routeToAddDetail();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
