import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class AddBrandGasMenu extends StatefulWidget {
  final GasBrandModel gasBrandModels;
  AddBrandGasMenu({Key key, this.gasBrandModels}) : super(key: key);
  @override
  State<AddBrandGasMenu> createState() => _AddBrandGasMenuState();
}

class _AddBrandGasMenuState extends State<AddBrandGasMenu> {
  GasBrandModel gasBrandModel;
  File file;
  String gas_brand_id, gas_brand_name, gas_brand_image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มประเภทแก๊ส'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            groupImage(),
            brandForm(),
            MyStyle().mySizebox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: 200.0,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'ยังไม่ได้เลือกรูปภาพ Camera หรือ Gallery');
          } else if (gas_brand_name == null || gas_brand_name.isEmpty) {
            normalDialog(context, 'กรุณากรอกให้ครบทุกช่อง !');
          } else {
            uploadGasAndInsertData();
          }
        },
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

  Future<Null> uploadGasAndInsertData() async {
    String urlUpload = '${MyConstant().domain}/gas/savebrandGas.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'gas$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urlUpload, data: formData).then((value) async {
        String gas_brand_image = '/gas/logobrand/$nameFile';
        print('path_image = ${MyConstant().domain}$gas_brand_image');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String gas_brand_id = preferences.getString('gas_brand_id');

        String urlInsertData =
            '${MyConstant().domain}/gas/addbrandgas.php?isAdd=true&gas_brand_id=$gas_brand_id&gas_brand_name=$gas_brand_name&gas_brand_image=$gas_brand_image';
        await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Widget brandForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => gas_brand_name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.import_contacts),
            labelText: 'ยี่ห้อแก๊ส',
            border: OutlineInputBorder(),
          ),
        ),
      );


  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          height: 250.0,
          child: file == null ? MyStyle().showLogo() : Image.file(file),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }

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
