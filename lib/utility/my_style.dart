import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.black;
  Color primaryColor = Colors.red;

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(BuildContext context,String string) {
    return Center(
      child: Container(width: MediaQuery.of(context).size.width*0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  BoxDecoration myBoxDecoretion(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/$namePic'), fit: BoxFit.cover),
    );
  }

  Container showLogo() {
    return Container(
      width: 160.0,
      child: Image.asset('assets/images/logogas.png'),
    );
  }

  Container showsignup(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FlatButton(
        child: Text(
          'SIGN UP',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        onPressed: () {
//                              Navigator.pop(context);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               // builder: (context) => SignUpPage(),
//             ),
//           );
        },
      ),
    );
  }

  FittedBox forgotpassword() {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.only(top: 0, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //          ForgotPasswordPage(),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  MyStyle();
}
