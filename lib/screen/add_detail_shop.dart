import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class AddDetailShop extends StatefulWidget {
  @override
  _AddDetailShopState createState() => _AddDetailShopState();
}

class _AddDetailShopState extends State<AddDetailShop> {
  //Field
  double lat = 7.03653660428109, lng = 100.46865206267121;
  File file;
  String nameShop, address, phone;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat = $lat, lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูลร้านค้า'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyStyle().mySizebox(),
            nameForm(),
            MyStyle().mySizebox(),
            addressForm(),
            MyStyle().mySizebox(),
            phoneForm(),
            MyStyle().mySizebox(),
            groupImage(),
            MyStyle().mySizebox(),
            lat == null ? MyStyle().showProgress() : showMap(),
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
      // width: 100.0,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (nameShop == null ||
              nameShop.isEmpty ||
              address == null ||
              address.isEmpty ||
              phone == null ||
              phone.isEmpty) {
            normalDialog(context, 'กรุณากรอกทุกช่อง');
          } else if (file == null) {
            normalDialog(context, 'กรุณาเลือกรูปภาพ');
          } else {
            uploadImage();
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'บันทึก',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop$i.jpg';

    String url = '${MyConstant().domain}/gasorderuser/Saveshop.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response =>> $value');
      });
    } catch (e) {}
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('PPS Shop'),
        position: LatLng(lat = 7.03653660428109, lng = 100.46865206267121),
        infoWindow: InfoWindow(
          title: 'ร้านPPSแก๊ส อยู่ที่นี่',
          snippet: 'ละติจูด = $lat , ลองติจูด = $lng',
        ),
      )
    ].toSet();
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          child: file == null
              ? Image.asset('assets/images/imageIcons.jpg')
              : Image.file(file),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker();
      PickedFile pickedFile = await object.getImage(
          source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = File(pickedFile.path);
      });
    } catch (e) {}
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => nameShop = value.trim(),
              decoration: InputDecoration(
                labelText: 'ชื่อร้าน :',
                prefixIcon: Icon(Icons.account_box),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => address = value.trim(),
              decoration: InputDecoration(
                labelText: 'ที่อยู่ร้าน :',
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => phone = value.trim(),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์ฺ :',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
