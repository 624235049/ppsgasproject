import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class AddDetailShop extends StatefulWidget {
  @override
  _AddDetailShopState createState() => _AddDetailShopState();
}

class _AddDetailShopState extends State<AddDetailShop> {
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
            showMap(),
            MyStyle().mySizebox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      width: 100.0,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {},
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

  Container showMap() {
    LatLng latLng = LatLng(7.036777083271106, 100.46753637917304);
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
          onPressed: () {},
        ),
        Container(
          width: 250.0,
          child: Image.asset('assets/images/imageIcons.jpg'),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
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
