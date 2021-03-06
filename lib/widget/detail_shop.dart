import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';
import 'package:ppsgasproject/screen/add_detail_shop.dart';
import 'package:ppsgasproject/screen/edit_detail_shop.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailShop extends StatefulWidget {
  String get id => null;

  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  DetailShopModel detailShopModel;

  @override
  void initState() {
    super.initState();
    readDataShop();
    // detailShopModel = widget.detailShopModel;
  }

  Future<Null> readDataShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url = '${MyConstant().domain}/gas/getdetailShop.php';
    await Dio().get(url).then((value) {
      print('value = $value');
      var result = json.decode(value.data);
      print('result = $result');
      for (var map in result) {
        setState(() {
          detailShopModel = DetailShopModel.fromJson(map);
        });
        print('nameShop = ${detailShopModel.nameShop}');
      }
    });
  }

  void routeToAddDetail() {
    Widget widget =
        detailShopModel.nameShop.isEmpty ? AddDetailShop() : EditInfoShop();
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        detailShopModel == null
            ? MyStyle().showProgress()
            : detailShopModel.nameShop.isEmpty
                ? showNoData(context)
                : showList(),
        addEditButton(),
      ],
    );
  }

  Widget showList() => Column(
        children: <Widget>[
          MyStyle().showTitleH2('?????????????????????????????????????????? ${detailShopModel.nameShop}'),
          showImage(),
          Row(
            children: [
              MyStyle().showTitleH2('??????????????????????????????????????????'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxWidth: 300.0),
                child: Text(
                  detailShopModel.address,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      fontSize: 17.0),
                ),
              ),
            ],
          ),
          MyStyle().mySizebox(),
          shopMap(),
        ],
      );

  Container showImage() {
    return Container(
      width: 200.0,
      height: 200.0,
      child:
          Image.network('${MyConstant().domain}${detailShopModel.urlPicture}'),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId(
            'shopID',
          ),
          position: LatLng(
            double.parse(detailShopModel.lat),
            double.parse(detailShopModel.lng),
          ),
          infoWindow: InfoWindow(
              title: '?????????????????????????????????',
              snippet:
                  '?????????????????????  = ${detailShopModel.lat} , ???????????????????????? = ${detailShopModel.lng}'))
    ].toSet();
  }

  Widget shopMap() {
    double lat = double.parse(detailShopModel.lat);
    double lng = double.parse(detailShopModel.lng);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 16.0);

    return Expanded(
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Widget showNoData(BuildContext context) =>
      MyStyle().titleCenter(context, '?????????????????????????????????????????????????????????????????????????????????????????????');

  Row addEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  routeToAddDetail();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
