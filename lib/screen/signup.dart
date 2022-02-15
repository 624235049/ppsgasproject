import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          myLogo(),
          MyStyle().mySizebox(),
          showAppName(),
          MyStyle().mySizebox(),
          nameForm(),
          MyStyle().mySizebox(),
          userForm(),
          MyStyle().mySizebox(),
          passwordForm(),
          MyStyle().mySizebox(),
          MyStyle().showTitleH2('ชนิดของสมาชิก :'),
          MyStyle().mySizebox(),
          userRadio(),
          employeeRadio(),
          MyStyle().mySizebox(),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {
            print(
                'name = $name, user = $user, password = $password, chooseType = $chooseType');
            if (name == null ||
                name.isEmpty ||
                user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              print('Have space');
              normalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบครับ');
            }else if(chooseType == null){
              normalDialog(context, 'โปรดเลือกชนิดของผู้สมัคร');
            }else {
              checkUser();
            }
          },
          child: Text(
            'สมัครสมาชิก',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      Future<Null> checkUser()async{
        String url = 'http://192.168.31.104:8080/gasorderuser/getUserWhereUser.php?isAdd=true&User=$user';
        try{
          Response response = await Dio().get(url);
          if(response.toString() == 'null'){
            registerThread();
          }else{
            normalDialog(context, 'User นี้ $user มีคนใช้แล้วกรุณาเปลี่ยน User ใหม่ค่ะ!');
          }
        }catch (e){

        }

      }



      Future<Null> registerThread()async{
        String url = 'http://192.168.31.104:8080/gasorderuser/adduser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';
        try{
          Response response = await Dio().get(url);
          print('res = $response');

          if (response.toString() == 'true'){
            Navigator.pop(context);
          }else{
            normalDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่ ค่ะ');
          }
        }catch (e){

        }
      }


  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                    value: 'Customer',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text(
                  'ลูกค้า',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget employeeRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                    value: 'Employee',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text(
                  'พนักงานขนส่ง',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(
                  color: MyStyle().darkColor,
                ),
                labelText: 'Name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
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
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('สมัครสมาชิก'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showLogo(),
        ],
      );
}
