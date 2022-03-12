import 'package:flutter/material.dart';
import 'package:ppsgasproject/screen/add_gas_menu.dart';

class ListGasShop extends StatefulWidget {
  @override
  _ListGasShopState createState() => _ListGasShopState();
}

class _ListGasShopState extends State<ListGasShop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text('รายการแก๊สของร้าน'),
        addGasButton(),
      ],
    );
  }

  Widget addGasButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddGasMenu(),
                    );
                    Navigator.push(context, route);
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}
