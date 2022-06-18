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
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/widget/oder_list_user.dart';
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

  List<GasBrandModel> gasbrandModels = List();
  List<Widget> brandimageCards = List();

  int currentIndex = 0;
  bool exitPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    readShop();
  }

  Future<Null> readShop() async {
    String url = '${MyConstant().domain}/gas/gasbrand.php';

    await Dio().get(url).then((value) {
      // print('value ==> $value');
      var result = json.decode(value.data);
      // print('result ==> $result');

      for (var map in result) {
        // print('item ==> $item');
        GasBrandModel model = GasBrandModel.fromJson(map);
        // print('brand gas ==>> ${model.brandGas}');

        String gas_brand_image = model.gas_brand_image;
        if (gas_brand_image.isNotEmpty) {
          setState(() {
            gasbrandModels.add(model);
            brandimageCards.add(createCard(model));
          });
        }
      }
    });
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
        title: Text(nameUser == null ? 'Main User' : 'สวัสดีคุณ < $nameUser >'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_sharp),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      // drawer: showDrawer(),
      body: brandimageCards.length == 0
          ? MyStyle().showProgress()
          : GridView.extent(
              maxCrossAxisExtent: 150.0,
              children: brandimageCards,
            ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'HISTORY',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_add),
              label: 'NOTIFICATION',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              label: 'PROFILE',
              backgroundColor: Colors.red),
        ],
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

  // Drawer showDrawer() => Drawer(
  //       child: ListView(
  //         children: <Widget>[
  //           showHead(),
  //         ],
  //       ),
  //     );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxDecoretion('bgprofile3.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Name Login'),
        accountEmail: Text(' Login!'));
  }

  Widget createCard(GasBrandModel gasbrandModels) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: Image.network(
                '${MyConstant().domain}${gasbrandModels.gas_brand_image}'),
          ),
          Text(gasbrandModels.gas_brand_name),
        ],
      ),
    );
  }
}
