import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/show_shop_cart.dart';
import 'package:ppsgasproject/utility/theme.dart';

class MyStyle {
  Color darkColor = Colors.black;
  Color primaryColor = Colors.red;

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget iconShowCart(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_shopping_cart),
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowCart(),
        );
        Navigator.push(context, route);
      },
    );
  }

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
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

//https://github.com/whisnuys/simple-login-page/blob/main/lib/login_page.dart //link ตกแต่งหน้าlogin github
  TextStyle mainTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xff2972ff),
  );

  TextStyle mainh2Title = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  TextStyle mainh1Title = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  TextStyle mainh3Title = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

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

  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            color: Color(0xff222222),
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
      width: 250.0,
      child: Image.asset('assets/images/splash_logo.png'),
    );
  }

  Container backlogo() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash_logo.png'),
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.10), BlendMode.modulate),
        ),
      ),
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

//================================================= Custom Button
class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
        child: MaterialButton(
          onPressed: callback,
          minWidth: 140.0,
          height: 35.0,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

//================================================= Border Button
class BorderButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const BorderButton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        child: MaterialButton(
          onPressed: callback,
          minWidth: 130.0,
          height: 30.0,
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

//================================================ Hex Color

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
