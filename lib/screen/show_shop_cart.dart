import 'package:flutter/material.dart';
import 'package:ppsgasproject/model/cart_model.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:ppsgasproject/utility/sqlite_helper.dart';

class ShowCart extends StatefulWidget {
  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<CartModel> cartModels = List();
  int total = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    var object = await SQLiteHelper().readAllDataFormSQLite();

    for (var model in object) {
      String sumString = model.sum;
      int sumInt = int.parse(sumString);

      setState(() {
        cartModels = object;
        total = total + sumInt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
      ),
      body: cartModels.length == 0
          ? MyStyle().showProgress()
          : SingleChildScrollView(
              child: buildcontents(),
            ),
    );
  }

  Widget buildcontents() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildmaintitleshop(),
          Divider(
            color: Colors.black26,
            height: 30,
            thickness: 5,
          ),
          buildheadtitle(),
          buildlistGas(),
          Divider(
            height: 50,
            thickness: 10,
          ),
          buildTotal(),
          MyStyle().mySizebox(),
        ],
      ),
    );
  }

  Widget buildTotal() => Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyStyle().showTitleH2('ยอดรวมทั้งสิ้น = '),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: MyStyle().showTitleHC('${total.toString()} THB'),
          ),
        ],
      );

  Widget buildmaintitleshop() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              MyStyle().showTitle('รายการในตะกร้า'),
            ],
          ),
          MyStyle().mySizebox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStyle()
                  .showTitleH3('ระยะทาง : ${cartModels[0].distance} กิโลเมตร'),
              MyStyle()
                  .showTitleH3('ค่าจัดส่ง : ${cartModels[0].transport} บาท'),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     MyStyle().showTitleH3('ค่าจัดส่ง ${cartModels[0].transport}'),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget buildheadtitle() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('จำนวน'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('ยี่ห้อ'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('ขนาด'),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH2('ราคา'),
          ),
        ],
      ),
    );
  }

  Widget buildlistGas() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: cartModels.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '${cartModels[index].amount}x',
                    style: MyStyle().mainhATitle,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    cartModels[index].gas_brand_name,
                    style: MyStyle().mainh2Title,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${cartModels[index].gas_size_id}ฺ kg.',
                    style: MyStyle().mainhPTitle,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    ' ${cartModels[index].sum}ฺ THB',
                    style: MyStyle().mainh2Title,
                  ),
                ),
              ],
            ),
          );
        },
      );
}

// Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Text(cartModels[index].gas_brand_name),
//             ),
//             Expanded(
//               flex: 1,
//               child: Text(cartModels[index].price),
//             ),
//             Expanded(
//               flex: 1,
//               child: Text(cartModels[index].amount),
//             ),
//           ],
//         ),
