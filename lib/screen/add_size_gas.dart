import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_size_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class AddSizeGasMenu extends StatefulWidget {
  final GasSizeModel gasSizeModels;
  AddSizeGasMenu({Key key, this.gasSizeModels}) : super(key: key);
  @override
  State<AddSizeGasMenu> createState() => _AddSizeGasMenuState();
}

class _AddSizeGasMenuState extends State<AddSizeGasMenu> {
  GasSizeModel gasSizeModels;
  File file;
  String gas_size_id, gas_size_name, pathImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการขนาดแก๊ส'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            groupImage(),
            sizeForm(),
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
          } else if (gas_size_name == null || gas_size_name.isEmpty) {
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
    String urlUpload = '${MyConstant().domain}/gas/savesizeGas.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'gas$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urlUpload, data: formData).then((value) async {
        String pathImage = '/gas/sizeimg/$nameFile';
        print('path_image = ${MyConstant().domain}$pathImage');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String gas_size_id = preferences.getString('gas_size_id');

        String urlInsertData =
            '${MyConstant().domain}/gas/addsizegas.php?isAdd=true&gas_size_id=$gas_size_id&gas_size_name=$gas_size_name&pathImage=$pathImage';
        await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Widget sizeForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => gas_size_name = value.trim(),
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
