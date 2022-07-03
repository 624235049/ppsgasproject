import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ppsgasproject/model/cart_model.dart';
import 'package:ppsgasproject/model/detailshop_model.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/model/gas_size_model.dart';
import 'package:ppsgasproject/utility/dialog.dart';
import 'package:ppsgasproject/utility/my_api.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';

import 'package:location/location.dart';
import 'package:ppsgasproject/utility/sqlite_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ShowMenuOderGas extends StatefulWidget {
  final GasBrandModel gasBrandModel;

  ShowMenuOderGas({Key key, this.gasBrandModel}) : super(key: key);
  @override
  State<ShowMenuOderGas> createState() => _ShowMenuOderGasState();
}

class _ShowMenuOderGasState extends State<ShowMenuOderGas> {
  GasBrandModel gasBrandModel;
  GasSizeModel gasSizeModel;
  double lat1, lng1, lat2, lng2;
  String gas_brand_id, gas_size_id, distanceString;
  List<GasModel> gasModels = List();
  List<GasSizeModel> gassizemodel = List();
  DetailShopModel detailShopModel;
  Location location = Location();

  int amount = 1;
  //
  // Location location = Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasBrandModel = widget.gasBrandModel;
    readDataShop();
    findLocation();
    readGasOrderMenu();
  }

  // Future<Null> findLocation() async {
  //   Location.instance.onLocationChanged.listen((event) {
  //     lat1 = event.latitude;
  //     lng1 = event.longitude;
  //     print(' lat1 = $lat1 lng1 = $lng1');
  //   });
  // }

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

  Future<Null> findLocation() async {
    Position position = await MyAPI().getLocation();
    lat1 = position.latitude;
    lng1 = position.longitude;
    print('lat1 == $lat1 , lng1 === $lng1');
  }

  Future<Null> readGasOrderMenu() async {
    setState(() {
      gas_brand_id = gasBrandModel.gas_brand_id;
    });
    String url =
        '${MyConstant().domain}/gas/getGasWhereidShop.php?isAdd=true&gas_brand_id=$gas_brand_id';
    Response response = await Dio().get(url);
    // print('res1 --> $response');
    var result = json.decode(response.data);
    // print('result =$result');

    for (var map in result) {
      GasModel gasModel = GasModel.fromJson(map);
      setState(() {
        gasModels.add(gasModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return gasModels.length == 0
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: gasModels.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // print('You click == $index');
                amount = 1;
                confirmOrder(index);
              },
              child: Row(
                children: [
                  showImageGas(context, index),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ขนาด ${gasModels[index].gas_size_id} kg',
                              style: MyStyle().mainTitle,
                            ),
                          ],
                        ),
                        Text('ราคา ${gasModels[index].price} บาท/ถัง',
                            style: MyStyle().mainh2Title),
                        Text('คงเหลือ ${gasModels[index].quantity} ถัง',
                            style: MyStyle().mainh2Title),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Container showImageGas(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      width: MediaQuery.of(context).size.width * 0.5 - 16.0,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(
        '${MyConstant().domain}${gasModels[index].path_image}',
        fit: BoxFit.cover,
      ),
    );
  }

  Future<Null> confirmOrder(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'รหัส : ${gasModels[index].gas_id} ',
                style: MyStyle().mainh1Title,
              ),
              Text(
                'ขนาด ${gasModels[index].gas_size_id} Kg',
                style: MyStyle().mainh1Title,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 200,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${MyConstant().domain}${gasModels[index].path_image}'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          amount++;
                        });
                      }),
                  Text(
                    amount.toString(),
                    style: MyStyle().mainh1Title,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                      size: 36,
                    ),
                    onPressed: () {
                      if (amount > 1) {
                        setState(() {
                          amount--;
                        });
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // print(
                        //     'Order ${gasModels[index].gas_size_id} = $amount');

                        addOrderToCart(index);
                      },
                      child: Text(
                        'ใส่ตะกร้า',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'ยกเลิก',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> addOrderToCart(int index) async {
    String gas_brand_id = gasBrandModel.gas_brand_id;
    String gas_brand_name = gasBrandModel.gas_brand_name;
    String gas_id = gasModels[index].gas_id;
    String gas_size_id = gasModels[index].gas_size_id;
    String price = gasModels[index].price;

    int priceInt = int.parse(price);
    int sumInt = priceInt * amount;
    lat2 = double.parse(detailShopModel.lat);
    lng2 = double.parse(detailShopModel.lng);
    double distance = MyAPI().calculate2Distance(lat1, lng1, lat2, lng2);

    var myFormat = NumberFormat('##0.0#', 'en_US');
    distanceString = myFormat.format(distance);

    int transport = MyAPI().calculateTransport(distance);

    print(
      'gas_id == $gas_id, gas_brand_id == $gas_brand_id, gas_brand_name $gas_brand_name gas_size_id == $gas_size_id price == $price amount == $amount, sum == $sumInt, distance == $distanceString, transport == $transport ',
    );

    Map<String, dynamic> map = Map();
    map['gas_id'] = gas_id;
    map['gas_brand_id'] = gas_brand_id;
    map['gas_brand_name'] = gas_brand_name;
    map['gas_size_id'] = gas_size_id;
    map['price'] = price;
    map['amount'] = amount.toString();
    map['sum'] = sumInt.toString();
    map['distance'] = distanceString;
    map['transport'] = transport.toString();

    print('map ==> ${map.toString()}');
    CartModel cartModel = CartModel.fromJson(map);

    var object = await SQLiteHelper().readAllDataFormSQLite();
    print('object lenght == ${object.length}');

    if (object.length == 0) {
      await SQLiteHelper().insertDataToSQLite(cartModel).then((value) => {
            print('insert Sucess'),
            showToast('Insert Sucess'),
          });
    } else {
      String id_brandSQLite = object[0].gas_brand_id;
      print('id_brandSQLite ==> $id_brandSQLite');
      if (gas_brand_id == id_brandSQLite) {
        await SQLiteHelper().insertDataToSQLite(cartModel).then((value) => {
              print('insert Sucess'),
              showToast('Insert Sucess'),
            });
      } else {
        normalDialog(context,
            'มีการทำรายการสั่งซื้อแก๊สยี่ห้อ ${object[0].gas_brand_name}อยู่กรุณาทำรายการก่อนหน้าเสร็จก่อน');
      }
    }
  }

  void showToast(String string) {
    Toast.show(
      string,
      context,
      duration: Toast.LENGTH_LONG,
    );
  }
}
