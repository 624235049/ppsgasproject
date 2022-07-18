import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/order_model.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_indicator/steps_indicator.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String user_id;
  bool statusOrder = true;
  List<OrderModel> orderModels = List();
  List<List<String>> listmenuGas = List();
  List<List<String>> listPrices = List();
  List<List<String>> listAmounts = List();
  List<List<String>> listSums = List();
  List<int> totalInts = List();
  List<int> statusInts = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finduser();
  }

  @override
  Widget build(BuildContext context) {
    return statusOrder ? buildNoneOrder() : buildcontent();
  }

  Widget buildcontent() => ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: orderModels.length,
        itemBuilder: (context, index) => Column(
          children: [
            MyStyle().mySizebox(),
            buildheadtitle(),
            buildDatetimeOrder(index),
            buildtransport(index),
            builddistance(index),
            buildListviewMenuGas(index),
            buildTotal(index),
            buildStepIndecator(statusInts[index]),
            MyStyle().mySizebox(),
          ],
        ),
      );

  Widget buildStepIndecator(int index) => Column(
        children: [
          StepsIndicator(
            lineLength: 80,
            selectedStep: index,
            nbSteps: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('สั่งซื้อ'),
              Text('กำลังเตรียมแก๊ส'),
              Text('กำลังจัดส่ง'),
              Text('รายการสำเร็จ'),
            ],
          ),
        ],
      );

  Widget buildTotal(int index) => Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyStyle().showTitleH3('รวมราคารายการแก๊ส :'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyStyle().showTitleHC(totalInts[index].toString()),
              ],
            ),
          ),
        ],
      );

  ListView buildListviewMenuGas(int index) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: listmenuGas[index].length,
        itemBuilder: (context, index2) => Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(listmenuGas[index][index2]),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(listAmounts[index][index2]),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(listPrices[index][index2]),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(listSums[index][index2]),
                ],
              ),
            ),
          ],
        ),
      );

  Container buildheadtitle() {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: MyStyle().showTitleH2('รายการแก๊ส'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('จำนวน'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('ราคา'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('รวม'),
          )
        ],
      ),
    );
  }

  Text buildamount(int index) =>
      MyStyle().showTitleH3('จำนวน ${orderModels[index].amount} ถัง');

  Text builddistance(int index) {
    return MyStyle()
        .showTitleH3('ระยะทาง ${orderModels[index].distance} กิโลเมตร');
  }

  Row buildtransport(int index) {
    return Row(
      children: [
        MyStyle().showTitleH3('ค่าจัดส่ง ${orderModels[index].transport} บาท'),
      ],
    );
  }

  Row buildDatetimeOrder(int index) {
    return Row(
      children: [
        MyStyle().showTitleH3(
            'วันเวลาที่สั่งซื้อ ${orderModels[index].orderDateTime}'),
      ],
    );
  }

  Row buildNameShop(int index) {
    return Row(
      children: [
        MyStyle().showTitleH3('ยี่ห้อ ${orderModels[index].gas_brand_name}'),
      ],
    );
  }

  Center buildNoneOrder() {
    return Center(
      child: Text(
        'ยังไม่มีข้อมูลการสั่งแก๊ส',
        style: TextStyle(fontSize: 28),
      ),
    );
  }

  Future<Null> finduser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('id');
    // print('user_id ==> $user_id');
    readOrderFromuserid();
  }

  Future<Null> readOrderFromuserid() async {
    if (user_id != null) {
      String url =
          '${MyConstant().domain}/gas/getOrderWhereuser_id.php?isAdd=true&user_id=$user_id';

      Response response = await Dio().get(url);
      // print('response ==> $response');
      if (response.toString() != 'null') {
        var result = jsonDecode(response.data);
        for (var map in result) {
          OrderModel model = OrderModel.fromJson(map);
          List<String> menuGas = changeArrey(model.gas_brand_name);
          List<String> prices = changeArrey(model.price);
          List<String> amounts = changeArrey(model.amount);
          List<String> sums = changeArrey(model.sum);

          int status = 0;
          switch (model.status) {
            case 'userorder':
              status = 0;
              break;
            case 'shopprocess':
              status = 1;
              break;
            case 'RiderHandle':
              status = 2;
              break;
            case 'Finish':
              status = 3;
              break;
            default:
          }
          // print('menuGas ==> $menuGas');
          int total = 0;
          for (var string in sums) {
            total = total + int.parse(string.trim());
          }
          print('total = $total');

          setState(() {
            statusOrder = false;
            orderModels.add(model);
            listmenuGas.add(menuGas);
            listPrices.add(prices);
            listAmounts.add(amounts);
            listSums.add(sums);
            totalInts.add(total);
            statusInts.add(status);
          });
        }
      }
    }
  }

  List<String> changeArrey(String string) {
    List<String> list = List();
    String myString = string.substring(1, string.length - 1);
    print('myString = $myString');
    list = myString.split(',');
    int index = 0;
    for (var string in list) {
      list[index] = string.trim();
      index++;
    }
    return list;
  }
}
