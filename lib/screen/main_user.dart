import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/screen/historypage.dart';
import 'package:ppsgasproject/screen/home.dart';
import 'package:ppsgasproject/screen/notification.dart';
import 'package:ppsgasproject/screen/profilepage.dart';
import 'package:ppsgasproject/screen/show_shop_gasmenu.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/widget/oder_list_user.dart';
import 'package:ppsgasproject/widget/show_list_shop.dart';
import 'package:ppsgasproject/widget/tab_bar_material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_style.dart';
import '../utility/signout_process.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;

  List<GasBrandModel> gasbrandModels = List();
  List<Widget> brandimageCards = List();
  Widget currentWidget;

  String currentPage;
  Widget tabbarWidget;
  bool exitPage = false;
  int index = 0;
  final pages = <Widget>[
    ShowListShop(),
    History(),
    NotificationPage(),
    Profile(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    currentWidget = ShowListShop();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          nameUser == null ? 'Main User' : 'สวัสดีคุณ < $nameUser >',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),

      // drawer: showDrawer(),
      body: pages[index],
      backgroundColor: Color(0xfff1f1f5),
      bottomNavigationBar: TabbarMaterialWidget(
        index: index,
        onChangedTab: onChangedTab,
      ),
    );
  }

  // Drawer showDrawer() => Drawer(
  //       child: ListView(
  //         children: <Widget>[
  //           showHead(),
  //         ],
  //       ),
  //     );

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoretion('bgprofile3.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Name Login'),
        accountEmail: Text(' Login!'));
  }
}
