import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/user_model.dart';
import 'package:ppsgasproject/screen/main_shop.dart';
import 'package:ppsgasproject/screen/main_user.dart';
import 'package:ppsgasproject/screen/man_emp.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/widget/detail_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_style.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter,
            //   colors: <Color>[
            //     Theme.of(context).primaryColor,
            //     Colors.redAccent
            //   ],
            // ),
            // // gradient: RadialGradient(
            // //   colors: <Color>[Colors.white, MyStyle().primaryColor],radius: 1.5,center: Alignment(0,-0.3),
            // // ),
            // boxShadow: [
            //   new BoxShadow(blurRadius: 5.0, color: Colors.grey)
            // ],
            // borderRadius: new BorderRadius.vertical(
            //     bottom: new Radius.elliptical(
            //         MediaQuery.of(context).size.width, 100.0)),
            ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().mySizebox(),
                MyStyle().showTitle('เข้าสู่ระบบ'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().forgotpassword(),
                LoginButton(),
                Container(
//                    padding: EdgeInsets.all(10),
//                      height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Divider(
                        height: 5,
                        color: Colors.black54,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text('Don\'t have an account?')),
                      MyStyle().showsignup(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget LoginButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่างกรุณากรอกให้ครบ ค่ะ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        'http://192.168.31.104:8080/gasorderuser/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.chooseType;
          if (chooseType == 'Customer') {
            RoutetoService(MainUser(), userModel);
          } else if (chooseType == 'Admin') {
            RoutetoService(MainShop(), userModel);
          } else if (chooseType == 'Employee') {
            RoutetoService(MainEmp(), userModel);
          } else {
            normalDialog(context, 'Error!');
          }
        } else {
          normalDialog(context, 'Password ผิด กรุณาลองใหม่อีกครั้ง ค่ะ');
        }
      }
    } catch (e) {}
  }

 

  Future<Null> RoutetoService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('ChooseType', userModel.chooseType);
    preferences.setString('Name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        margin: EdgeInsets.only(top: 10),
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(
              color: MyStyle().darkColor,
            ),
            labelText: 'User :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(
              color: MyStyle().darkColor,
            ),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
