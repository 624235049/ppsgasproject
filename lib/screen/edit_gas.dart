import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class EditGasMenu extends StatefulWidget {
  final GasModel gasModel;

  EditGasMenu({Key key, this.gasModel}) : super(key: key);

  @override
  State<EditGasMenu> createState() => _EditGasMenuState();
}

class _EditGasMenuState extends State<EditGasMenu> {
  GasModel gasModel;
  File file;
  String name, price, size, qty, pathImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasModel = widget.gasModel;
    name = gasModel.brandGas;
    price = gasModel.price;
    size = gasModel.size;
    qty = gasModel.quantity;
    pathImage = gasModel.pathImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: upoloadButton(),
      appBar: AppBar(
        title: Text('แก้ไข รายการแก๊ส ${gasModel.brandGas}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            brandGas(),
            groupImage(),
            MyStyle().mySizebox(),
            priceGas(),
            MyStyle().mySizebox(),
            sizeGas(),
            MyStyle().mySizebox(),
            qtyGas(),
            MyStyle().mySizebox(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton upoloadButton() {
    return FloatingActionButton(
      onPressed: () {
        if (name.isEmpty || price.isEmpty || qty.isEmpty) {
          normalDialog(context, 'กรุณากรอกให้ครบทุกช่องค่ะ!');
        } else {
          confirmEdit();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการเปลี่ยนแปลงรายการแก๊สใช่ไหม ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  editValueOnMySQL();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                label: Text('ตกลง'),
              ),
              FlatButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                label: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editValueOnMySQL() async {
    String id = gasModel.id;
    String url =
        '${MyConstant().domain}/gasorderuser/editGasWhereId.php?isAdd=true&id=$id&BrandGas=$name&PathImage=$pathImage&Price=$price&Quantity=$qty';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่มีอะไร ผิดพลาด!');
      }
    });
  }

  Row groupImage() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseImage(
              ImageSource.camera,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            width: 250.0,
            height: 250.0,
            child: file == null
                ? Image.network(
                    '${MyConstant().domain}${gasModel.pathImage}',
                    fit: BoxFit.cover,
                  )
                : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseImage(
              ImageSource.gallery,
            ),
          )
        ],
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget brandGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => name = value.trim(),
              initialValue: name,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget priceGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => price = value.trim(),
              initialValue: price,
              decoration: InputDecoration(
                labelText: 'ราคา',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget sizeGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => size = value.trim(),
              initialValue: size,
              decoration: InputDecoration(
                labelText: 'ขนาด',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget qtyGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => qty = value.trim(),
              initialValue: qty,
              decoration: InputDecoration(
                labelText: 'จำนวน',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
