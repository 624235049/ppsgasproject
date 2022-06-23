import 'dart:convert';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';

import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:ppsgasproject/widget/detail_shop.dart';
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
  Position userlocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataShop();
    findLatLng();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> getLocation() async {
    try {
      userlocation = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
      );
      return userlocation;
    } catch (e) {
      userlocation = null;
    }
  }

  Future<Null> findLatLng() async {
    Position position = await getLocation();
    setState(() {
      lat1 = position.latitude;
      lng1 = position.longitude;
      lat2 = double.parse(detailShopModel.lat);
      lng2 = double.parse(detailShopModel.lng);
      print('lat1 = $lat1, lng1 = $lng1, lat2 = $lat2, lng2 = $lng2');
      distance = calculateDistance(lat1, lng1, lat2, lng2);

      var myFormat = NumberFormat('#0.0#', 'en_US');
      distanceString = myFormat.format(distance);
    });
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        detailShopModel == null
            ? MyStyle().showProgress()
            : detailShopModel.nameShop.isEmpty
                ? showNoData(context)
                : showList()
      ],
    );
  }

  Widget showNoData(BuildContext context) =>
      MyStyle().titleCenter(context, 'ยังไม่มีข้อมูล');

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

  Widget showList() => Column(
        children: <Widget>[
          MyStyle().mySizebox(),
          MyStyle().showTitleH2('รายละเอียดร้าน ${detailShopModel.nameShop}'),
          MyStyle().mySizebox(),
          showImage(),
          MyStyle().mySizebox(),
          ListTile(
            leading: Icon(Icons.home_work_rounded),
            title: Text(detailShopModel.address),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(detailShopModel.phone),
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: Text(distance == null ? '' : '$distanceString กิโลเมตร'),
          ),
          ListTile(
            leading: Icon(Icons.transfer_within_a_station),
            title: Text('28 บาท'),
          ),
          MyStyle().mySizebox(),
          // shopMap(),
        ],
      );

  Container showImage() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.network(
        '${MyConstant().domain}${detailShopModel.urlPicture}',
        fit: BoxFit.cover,
      ),
    );
  }
}
