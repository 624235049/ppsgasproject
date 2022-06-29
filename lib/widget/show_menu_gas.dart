import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/model/gas_model.dart';
import 'package:ppsgasproject/model/gas_size_model.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppsgasproject/widget/gas_brand.dart';

class ShowMenuOderGas extends StatefulWidget {
  final GasBrandModel gasBrandModel;
  ShowMenuOderGas({Key key, this.gasBrandModel}) : super(key: key);
  @override
  State<ShowMenuOderGas> createState() => _ShowMenuOderGasState();
}

class _ShowMenuOderGasState extends State<ShowMenuOderGas> {
  GasBrandModel gasBrandModel;
  GasSizeModel gasSizeModel;
  String gas_brand_id, gas_size_id;
  List<GasModel> gasModels = List();
  List<GasSizeModel> gassizemodel = List();
  int amount = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gasBrandModel = widget.gasBrandModel;
    readGasOrderMenu();
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
    print('result =$result');

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
                print('You click == $index');
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
                        print(
                            'Order ${gasModels[index].gas_size_id} = $amount');

                        addOrderToCart();
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

  void addOrderToCart() {}
}
