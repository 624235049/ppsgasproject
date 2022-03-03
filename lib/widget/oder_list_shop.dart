import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  DetailShopModel detailShopModel;

  @override
  Widget build(BuildContext context) {
    return Text('รายการอาหารที่ลูกค้าสั่ง');
  }
}
