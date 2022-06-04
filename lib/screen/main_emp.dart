import 'package:flutter/material.dart';

import '../utility/my_style.dart';
import '../utility/signout_process.dart';

class MainEmp extends StatefulWidget {
  @override
  _MainEmpState createState() => _MainEmpState();
}

class _MainEmpState extends State<MainEmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Employee'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
    child: ListView(
      children: <Widget>[
        showHeadEmployee(),
      ],
    ),
  );
  UserAccountsDrawerHeader showHeadEmployee() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoretion('emp1.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Admin Login'),
        accountEmail: Text(' Login!'));
  }

}
