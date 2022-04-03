import 'package:flutter/material.dart';
import 'package:ppsgasproject/widget/detail_shop.dart';
import 'package:ppsgasproject/widget/list_gas.dart';
import 'package:ppsgasproject/widget/oder_list_shop.dart';
import 'package:ppsgasproject/widget/size_gas.dart';
import 'package:ppsgasproject/widget/type_gas.dart';

import '../utility/my_style.dart';
import '../utility/signout_process.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Admin PPS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadAdmin(),
            homeMenu(),
            gasMenu(),
            typeGasMenu(),
            sizeGasMenu(),
            detailgasMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการแก๊สที่ลูกค้าสั่ง'),
        subtitle: Text('รายการแก๊สที่ยังไม่ได้ส่งลูกค้า'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile gasMenu() => ListTile(
        leading: Icon(Icons.wallet_travel_sharp),
        title: Text('รายการแก๊ส'),
        // subtitle: Text('--'),
        onTap: () {
          setState(() {
            currentWidget = ListGasShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile typeGasMenu() => ListTile(
        leading: Icon(Icons.merge_type),
        title: Text('ประเภทแก๊ส'),
        onTap: () {
          setState(() {
            currentWidget = TypeGasShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile sizeGasMenu() => ListTile(
        leading: Icon(Icons.sanitizer),
        title: Text('ขนาดแก๊ส'),
        onTap: () {
          setState(() {
            currentWidget = SizeGasShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile detailgasMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียดของร้าน'),
        subtitle: Text('--'),
        onTap: () {
          setState(() {
            currentWidget = DetailShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.logout),
        title: Text('Sign Out'), onTap: () => signOutProcess(context),
        // subtitle: Text(''),
      );

  UserAccountsDrawerHeader showHeadAdmin() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoretion('bgprofile2.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Admin Login'),
        accountEmail: Text(' Login!'));
  }
}
