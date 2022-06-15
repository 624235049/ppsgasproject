import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGasMenu extends StatefulWidget {
  final GasModel gasModel;
  AddGasMenu({Key key, this.gasModel}) : super(key: key);

  @override
  State<AddGasMenu> createState() => _AddGasMenuState();
}

class _AddGasMenuState extends State<AddGasMenu> {
  GasModel gasModel;
  File file;
  String gas_brand_id, gas_size_id, path_image, price, size, quantity;

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
            sizeForm(),
            MyStyle().mySizebox(),
            quantityForm(),
            MyStyle().mySizebox(),
            // showTitleGas('ประเภทแก๊ส'),
            // PTTRadio(),
            // UNIQRadio(),
            // SiamRadio(),
            // WorldRadio(),
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
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'ยังไม่ได้เลือกรูปภาพ Camera หรือ Gallery');
          } else if (gas_brand_id == null ||
              gas_brand_id.isEmpty ||
              price == null ||
              price.isEmpty ||
              gas_size_id == null ||
              gas_size_id.isEmpty ||
              quantity == null ||
              quantity.isEmpty) {
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
    String urlUpload = '${MyConstant().domain}/gas/saveGas.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'gas$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urlUpload, data: formData).then((value) async {
        String path_image = '/gas/Gas/$nameFile';
        print('path_image = ${MyConstant().domain}$path_image');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String gas_id = preferences.getString('gas_id');

        String urlInsertData =
            '${MyConstant().domain}/gas/addGas.php?isAdd=true&gas_id=$gas_id&gas_brand_id=$gas_brand_id&gas_size_id=$gas_size_id&path_image=$path_image&price=$price&quantity=$quantity';
        await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Widget nameForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => gas_brand_id = value.trim(),
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
          keyboardType: TextInputType.number,
          onChanged: (value) => price = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money),
            labelText: 'ราคาแก๊ส',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget sizeForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => gas_size_id = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.merge_type),
            labelText: 'ขนาดแก๊ส',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget quantityForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => quantity = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.production_quantity_limits),
            labelText: 'จำนวนแก๊ส',
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
          child: file == null
              ? Image.asset('assets/images/gasimg2.png')
              : Image.file(file),
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

  // Widget PTTRadio() => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: 250.0,
  //           child: Row(
  //             children: <Widget>[
  //               Radio(
  //                   value: 'pttgas',
  //                   groupValue: gasType,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       gasType = value;
  //                     });
  //                   }),
  //               Text(
  //                 'ปตท.แก๊ส',
  //                 style: TextStyle(color: MyStyle().darkColor),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );

  // Widget UNIQRadio() => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: 250.0,
  //           child: Row(
  //             children: <Widget>[
  //               Radio(
  //                   value: 'uniquegas',
  //                   groupValue: gasType,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       gasType = value;
  //                     });
  //                   }),
  //               Text(
  //                 'ยูนิคแก๊ส',
  //                 style: TextStyle(color: MyStyle().darkColor),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );

  // Widget WorldRadio() => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: 250.0,
  //           child: Row(
  //             children: <Widget>[
  //               Radio(
  //                   value: 'worldgas',
  //                   groupValue: gasType,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       gasType = value;
  //                     });
  //                   }),
  //               Text(
  //                 'เวิลด์แก๊ส',
  //                 style: TextStyle(color: MyStyle().darkColor),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );

  // Widget SiamRadio() => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: 250.0,
  //           child: Row(
  //             children: <Widget>[
  //               Radio(
  //                   value: 'siamgas',
  //                   groupValue: gasType,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       gasType = value;
  //                     });
  //                   }),
  //               Text(
  //                 'สยามแก๊ส',
  //                 style: TextStyle(color: MyStyle().darkColor),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );

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
