import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/gas_brand_model.dart';
import 'package:ppsgasproject/screen/show_shop_gasmenu.dart';
import 'package:ppsgasproject/utility/my_constant.dart';
import 'package:ppsgasproject/utility/my_style.dart';

class ShowListShop extends StatefulWidget {
  @override
  State<ShowListShop> createState() => _ShowListShopState();
}

class _ShowListShopState extends State<ShowListShop> {
  List<GasBrandModel> gasbrandModels = List();
  List<Widget> brandimageCards = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readBrand();
  }

  Future<Null> readBrand() async {
    String url = '${MyConstant().domain}/gas/gasbrand.php';

    await Dio().get(url).then((value) {
      // print('value ==> $value');
      var result = json.decode(value.data);
      int index = 0;
      // print('result ==> $result');

      for (var map in result) {
        // print('item ==> $item');
        GasBrandModel model = GasBrandModel.fromJson(map);
        // print('brand gas ==>> ${model.brandGas}');

        String gas_brand_image = model.gas_brand_image;
        if (gas_brand_image.isNotEmpty) {
          setState(() {
            gasbrandModels.add(model);
            brandimageCards.add(createCard(model, index));
            index++;
          });
        }
      }
    });
  }

  Widget createCard(GasBrandModel gasbrandModel, int index) {
    return GestureDetector(
      onTap: () {
        print('Your click index $index');
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowShopGasMenu(
            gasBrandModels: gasbrandModels[index],
          ),
        );
        Navigator.push(context, route);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130.0,
              height: 130.0,
              child: Image.network(
                  '${MyConstant().domain}${gasbrandModel.gas_brand_image}'),
            ),
            MyStyle().showTitleH3(gasbrandModel.gas_brand_name),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return brandimageCards.length == 0
        ? MyStyle().showProgress()
        : GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 2,
            children: brandimageCards,
          );
  }
}
