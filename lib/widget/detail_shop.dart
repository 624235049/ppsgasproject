import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/add_detail_shop.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class DetailShop extends StatefulWidget {
  String get id => null;

  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  void routeToAddDetail() {
    print('routeToAddDetail Work');
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddDetailShop(),
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyStyle().titleCenter(context, 'ยังไม่มีข้อมูลกรุณาเพิ่มด้วยค่ะ'),
        addEditButton(),
      ],
    );
  }

  Row addEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  routeToAddDetail();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
