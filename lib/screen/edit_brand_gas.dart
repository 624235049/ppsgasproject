import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';

class EditBrandGas extends StatefulWidget {
  final GasBrandModel gasbrandModel;

  EditBrandGas({Key key, this.gasbrandModel}) : super(key: key);

  @override
  State<EditBrandGas> createState() => _EditBrandGasState();
}

class _EditBrandGasState extends State<EditBrandGas> {
  GasBrandModel gasBrandModel;
  File file;
  String gas_brand_id, brand_name, brand_image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasBrandModel = widget.gasbrandModel;
    brand_name = gasBrandModel.gas_brand_name;
    brand_image = gasBrandModel.gas_brand_image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: upoloadButton(),
      appBar: AppBar(
        title: Text('แก้ไขประเภทแก๊ส ${gasBrandModel.gas_brand_name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            brandGas(),
            groupImage(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton upoloadButton() {
    return FloatingActionButton(
      onPressed: () {
        if (brand_name.isEmpty || brand_image.isEmpty) {
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
        title: Text(
            'คุณต้องการเปลี่ยนแปลงรายการแก๊ส${gasBrandModel.gas_brand_name}ใช่ไหม ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  editbrandMySQL();
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

  Future<Null> editbrandMySQL() async {
    String gas_brand_id = gasBrandModel.gas_brand_id;
    String url =
        '${MyConstant().domain}/gas/editbrandgas.php?isAdd=true&gas_brand_id=$gas_brand_id&gas_brand_name=$brand_name&gas_brand_image=$brand_image';
    await Dio().get(url).then(
      (value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
        } else {
          normalDialog(context, 'กรุณาลองใหม่มีอะไรผิดพลาด !');
        }
      },
    );
  }

  Widget brandGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => brand_name = value.trim(),
              initialValue: brand_name,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

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
            width: 200.0,
            height: 200.0,
            child: file == null
                ? Image.network(
                    '${MyConstant().domain}${gasBrandModel.gas_brand_image}',
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
}
