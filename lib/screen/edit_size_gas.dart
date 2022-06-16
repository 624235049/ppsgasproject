import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/model/gas_size_model.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class EditSizeGas extends StatefulWidget {
  final GasSizeModel gassizeModels;
  EditSizeGas({Key key, this.gassizeModels}) : super(key: key);

  @override
  State<EditSizeGas> createState() => _EditSizeGasState();
}

class _EditSizeGasState extends State<EditSizeGas> {
  GasSizeModel gasSizeModel;
  File file;
  String gas_size_id, gas_size_name, pathImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasSizeModel = widget.gassizeModels;
    gas_size_name = gasSizeModel.gas_size_name;
    pathImage = gasSizeModel.pathImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขรายการขนาดแก๊ส ${gasSizeModel.gas_size_name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            groupImage(),
            sizeGas(),
            MyStyle().mySizebox(),
            saveeditButton(),
          ],
        ),
      ),
    );
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
                    '${MyConstant().domain}${gasSizeModel.pathImage}',
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

  Widget sizeGas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => gas_size_name = value.trim(),
              initialValue: gas_size_name,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget saveeditButton() {
    return Container(
      width: 200.0,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (gas_size_name == null || gas_size_name.isEmpty) {
            normalDialog(context, 'กรุณากรอกให้ครบทุกช่อง !');
          } else {
            confirmEdit();
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

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
            'คุณต้องการเปลี่ยนแปลงรายการแก๊ส${gasSizeModel.gas_size_name}ใช่ไหม ?'),
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
    String gas_size_id = gasSizeModel.gas_size_id;
    String url =
        '${MyConstant().domain}/gas/editsizegas.php?isAdd=true&gas_size_id=$gas_size_id&gas_size_name=$gas_size_name&pathImage=$pathImage';
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
}
