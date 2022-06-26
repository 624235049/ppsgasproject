import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:ppsgasproject/widget/about_shop.dart';
import 'package:ppsgasproject/widget/detail_shop.dart';
import 'package:ppsgasproject/widget/show_list_shop.dart';
import 'package:ppsgasproject/widget/show_menu_gas.dart';
import 'package:ppsgasproject/widget/tabbar_about_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowShopGasMenu extends StatefulWidget {
  final GasBrandModel gasBrandModel;
  ShowShopGasMenu({Key key, this.gasBrandModel}) : super(key: key);
  @override
  State<ShowShopGasMenu> createState() => _ShowShopGasMenuState();
}

class _ShowShopGasMenuState extends State<ShowShopGasMenu> {
  GasBrandModel gasBrandModel;
  List<Widget> pages = List();
  String nameShop;
  Widget currentWidget;
  String currentPage;
  Widget tabbarWidget;
  int indexPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasBrandModel = widget.gasBrandModel;
    currentWidget = ShowListShop();
    pages.add(
      ShowMenuOderGas(
        gasBrandModel: gasBrandModel,
      ),
    );
    pages.add(
      AboutShop(),
    );
  }

  // final pages = <Widget>[
  //   ShowMenuOderGas(),
  //   AboutShop(),
  // ];

  void onChangedTab(int index) {
    setState(() {
      this.indexPage = index;
    });
  }

  BottomNavigationBarItem aboutShopbtn() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.article_sharp),
      label: 'รายละเอียดร้าน',
    );
  }

  BottomNavigationBarItem gasorderbtn() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.add_shopping_cart),
      label: 'รายการแก๊ส',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สั่งซื้อ รายการ ${gasBrandModel.gas_brand_name}'),
      ),
      body: pages.length == 0 ? MyStyle().showProgress() : pages[indexPage],
      bottomNavigationBar: TabbaraboutandOrder(
        index: indexPage,
        onChangedTab: onChangedTab,
      ),
    );
  }
}
