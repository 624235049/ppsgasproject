import 'dart:convert';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';
import 'package:ppsgasproject/utility/my_api.dart';

import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:ppsgasproject/utility/my_style.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AboutShop extends StatefulWidget {
  final DetailShopModel detailShopModel;
  AboutShop({Key key, this.detailShopModel}) : super(key: key);

  @override
  State<AboutShop> createState() => _AboutShopState();
}

class _AboutShopState extends State<AboutShop> {
  Position userLocation;
  GoogleMapController mapController;
  DetailShopModel detailShopModel;
  double lat1, lng1, lat2, lng2, distance;
  String distanceString;
  int transport;
  Position userlocation;
  CameraPosition position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataShop();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    Position position = await MyAPI().getLocation();
    setState(() {
      lat1 = position.latitude;
      lng1 = position.longitude;
      lat2 = double.parse(detailShopModel.lat);
      lng2 = double.parse(detailShopModel.lng);
      print('lat1 = $lat1, lng1 = $lng1, lat2 = $lat2, lng2 = $lng2');
      distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

      var myFormat = NumberFormat('#0.0#', 'en_US');
      distanceString = myFormat.format(distance);

      transport = MyAPI().calculateTransport(distance);
      print('distance = $distance');
      print('transport = $transport');
    });
  }

  Future<Null> readDataShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url = '${MyConstant().domain}/gas/getdetailShop.php';
    await Dio().get(url).then((value) {
      // print('value = $value');
      var result = json.decode(value.data);
      // print('result = $result');
      for (var map in result) {
        setState(() {
          detailShopModel = DetailShopModel.fromJson(map);
        });
        // print('nameShop = ${detailShopModel.nameShop}');
      }
    });
  }

  // Future<LocationData> findLocationData() async {
  //   Location location = Location();
  //   try {
  //     return await location.getLocation();
  //   } catch (e) {
  //     location = null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          detailShopModel == null
              ? MyStyle().showProgress()
              : detailShopModel.nameShop.isEmpty
                  ? showNoData(context)
                  : showList()
        ],
      ),
    );
  }

  Widget showNoData(BuildContext context) =>
      MyStyle().titleCenter(context, 'ยังไม่มีข้อมูล');

  Widget showList() => Column(
        children: <Widget>[
          MyStyle().mySizebox(),
          MyStyle().showTitleH2('${detailShopModel.nameShop}'),
          MyStyle().mySizebox(),
          showMap(),
          ListTile(
            leading: Icon(Icons.home_work_rounded),
            title: Text(detailShopModel.address),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(detailShopModel.phone),
          ),
          ListTile(
            leading: Icon(Icons.social_distance),
            title: Text(distance == null
                ? 'กำลังคำนวณระยะทาง...'
                : '$distanceString กิโลเมตร'),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title:
                Text(transport == null ? 'กำลังคำนวณราคา..' : '$transport บาท'),
          ),
          MyStyle().mySizebox(),
        ],
      );

  Container showMap() {
    if (lat1 != null) {
      LatLng latLng1 = LatLng(lat1, lng1);
      position = CameraPosition(
        target: latLng1,
        zoom: 12.0,
      );
    }

    Marker userMarker() {
      return Marker(
        markerId: MarkerId('userMarker'),
        position: LatLng(lat1, lng1),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow: InfoWindow(title: 'คุณอยู่ที่นี่'),
      );
    }

    Marker shopMarker() {
      return Marker(
        markerId: MarkerId('shopMarker'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(150.0),
        infoWindow: InfoWindow(title: 'ร้านPPSแก๊ส'),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker(), shopMarker()].toSet();
    }

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
      // color: Colors.grey,
      height: 250,
      child: lat1 == null
          ? MyStyle().showProgress()
          : GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: mySet(),
            ),
    );
  }

  // Container showImage() {
  //   return Container(
  //     width: 200.0,
  //     height: 200.0,
  //     child: Image.network(
  //       '${MyConstant().domain}${detailShopModel.urlPicture}',
  //       fit: BoxFit.cover,
  //     ),
  //   );
  // }
}
