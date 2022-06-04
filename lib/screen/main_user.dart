import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_style.dart';
import '../utility/signout_process.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;
  bool pttgas = false;
  bool worldgas = false;
  bool uniquegas = false;
  bool siamgas = false;
  String gasImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> readShop() async {}

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
        title: Text(nameUser == null ? 'Main User' : 'สวัสดีคุณ $nameUser '),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_sharp),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showDrawer(),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                'Order Now',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ImagePtt(context),
                        Imageworld(context),

                        //=========ImageSecondrow
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Imageunique(context),
                        Imagesiam(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30,
                right: 20,
              ),
              width: double.infinity,
              alignment: Alignment.bottomRight,
              child: CustomButton(
                text: 'Next',
                callback: () {
                  if (gasImage == null) {
                    normalDialog(context, 'กรุณาเลือกยี่ห้อแก๊ส !');
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {},
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell Imagesiam(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          siamgas = true;
          gasImage = 'assets/images/sl.png';
          pttgas = false;
          worldgas = false;
          uniquegas = false;
        });
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: siamgas
            ? BoxDecoration(border: Border.all(color: Colors.red))
            : null,
        child: Card(
          borderOnForeground: siamgas,
          elevation: 3,
          child: Image.asset(
            'assets/images/unin.png',
            width: 160,
          ),
        ),
      ),
    );
  }

  InkWell ImagePtt(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          pttgas = true;
          gasImage = 'assets/images/ptt.png';
          worldgas = false;
          uniquegas = false;
          siamgas = false;
        });
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: pttgas
            ? BoxDecoration(border: Border.all(color: Colors.red))
            : null,
        child: Card(
          borderOnForeground: pttgas,
          elevation: 3,
          child: Image.asset(
            'assets/images/ptt.png',
            width: 160,
          ),
        ),
      ),
    );
  }

  InkWell Imageworld(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          worldgas = true;
          gasImage = 'assets/images/wp.png';
          pttgas = false;
          uniquegas = false;
          siamgas = false;
        });
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: worldgas
            ? BoxDecoration(border: Border.all(color: Colors.red))
            : null,
        child: Card(
          borderOnForeground: worldgas,
          elevation: 3,
          child: Image.asset(
            'assets/images/wp.png',
            width: 160,
          ),
        ),
      ),
    );
  }

  InkWell Imageunique(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          uniquegas = true;
          gasImage = 'assets/images/unin.png';
          pttgas = false;
          worldgas = false;
          siamgas = false;
        });
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: uniquegas
            ? BoxDecoration(border: Border.all(color: Colors.red))
            : null,
        child: Card(
          borderOnForeground: uniquegas,
          elevation: 3,
          child: Image.asset(
            'assets/images/sl.png',
            width: 160,
          ),
        ),
      ),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
          ],
        ),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoretion('bgprofile3.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Name Login'),
        accountEmail: Text(' Login!'));
  }
}
