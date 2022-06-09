import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ppsgasproject/model/gas_size_model.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class SizeGasShop extends StatefulWidget {
  @override
  State<SizeGasShop> createState() => _SizeGasShopState();
}

class _SizeGasShopState extends State<SizeGasShop> {
  bool loadStatus = true;
  bool status = true;
  List<GasSizeModel> gassizeModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSizeGas();
  }

  Future<Null> readSizeGas() async {
    if (gassizeModel.length != 0) {
      gassizeModel.clear();
    }
    String url = '${MyConstant().domain}/gas/gas_size.php';

    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      // print('value ==> $value');
      var result = json.decode(value.data);
      // print('result ==> $result');

      for (var item in result) {
        // print('item ==> $item');
        GasSizeModel model = GasSizeModel.fromJson(item);
        // print('brand gas ==>> ${model.brandGas}');

        setState(() {
          gassizeModel.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyStyle().backlogo(),
        loadStatus ? MyStyle().showProgress() : showContent(),
        // addGasButton(),
      ],
    );
  }

  Widget showContent() {
    return status
        ? showSizeGas()
        : Center(
            child: Text('ยังไม่มีรายการแก๊ส'),
          );
  }

  Widget showSizeGas() => ListView.builder(
        itemCount: gassizeModel.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Image.network(
                  '${MyConstant().domain}${gassizeModel[index].pathImage}'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ID : ${gassizeModel[index].gasSizeId} ',
                      style: MyStyle().mainTitle,
                    ),
                    Text(
                      'ไซส์ ${gassizeModel[index].gasSizeName} ',
                      style: MyStyle().mainh2Title,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            MaterialPageRoute route =
                                MaterialPageRoute(builder: (context) => null);
                            Navigator.push(context, route).then(
                              (value) => readSizeGas(),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          // onPressed: () => deleteGas(gasmodels[index]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
