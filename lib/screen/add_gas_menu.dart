import 'package:flutter/material.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class AddGasMenu extends StatefulWidget {
  @override
  State<AddGasMenu> createState() => _AddGasMenuState();
}

class _AddGasMenuState extends State<AddGasMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการแก๊ส'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showTitleGas('รูปแก๊ส'),
            groupImage(),
            showTitleGas('รายละเอียดแก๊ส'),
            nameForm(),
            MyStyle().mySizebox(),
            priceForm(),
            MyStyle().mySizebox(),
            detailForm(),
            MyStyle().mySizebox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {},
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save GasMenu',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget nameForm() => Container(
        width: 250.0,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.gavel_sharp),
            labelText: 'ยี่ห้อแก๊ส',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget priceForm() => Container(
        width: 250.0,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money),
            labelText: 'ราคาแก๊ส',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget detailForm() => Container(
        width: 250.0,
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.details),
            labelText: 'รายละเอียดแก๊ส',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
        Container(
          width: 250.0,
          height: 250.0,
          child: Image.asset('assets/images/gasimg2.png'),
        ),
        IconButton(icon: Icon(Icons.add_photo_alternate), onPressed: null),
      ],
    );
  }

  Widget showTitleGas(String string) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          MyStyle().showTitleH2(string),
        ],
      ),
    );
  }
}
