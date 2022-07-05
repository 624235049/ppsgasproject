import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppsgasproject/model/cart_model.dart';
import 'package:ppsgasproject/utility/my_style.dart';
import 'package:ppsgasproject/utility/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';

class ShowCart extends StatefulWidget {
  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<CartModel> cartModels = List();
  int total = 0;
  bool status = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    var object = await SQLiteHelper().readAllDataFormSQLite();
    print('object length ==> ${object.length}');
    if (object.length != 0) {
      for (var model in object) {
        String sumString = model.sum;
        int sumInt = int.parse(sumString);
        setState(() {
          status = false;
          cartModels = object;
          total = total + sumInt;
        });
      }
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
      ),
      body: status
          ? Center(
              child: Text('ตะกร้าว่างเปล่า'),
            )
          : buildcontents(),
    );
  }

  Widget buildcontents() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildmaintitleshop(),
            Divider(
              color: Colors.black26,
              height: 30,
              thickness: 5,
            ),
            buildclearshop(),
            buildheadtitle(),
            buildlistGas(),
            Divider(
              height: 50,
              thickness: 10,
            ),
            buildTotal(),
            MyStyle().mySizebox(),
            buildAddOrderButton(),
          ],
        ),
      ),
    );
  }

  Row buildclearshop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              confirmDeleteAllData();
            },
            child: Text('ลบรายการทั้งหมด')),
      ],
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
            child: MyStyle().showTitleH2('ผลรวม'),
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
                  flex: 2,
                  child: Text(
                    '${cartModels[index].amount}x',
                    style: MyStyle().mainhATitle,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    cartModels[index].gas_brand_name,
                    style: MyStyle().mainh2Title,
                  ),
                ),
                Expanded(
                  flex: 2,
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
                Expanded(
                  flex: 1,
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete_forever),
                    onPressed: () async {
                      int id = cartModels[index].id;
                      print('You Click delete id = $id');
                      await SQLiteHelper().deleteDataWhereId(id).then(
                        (value) {
                          print('delete Success id =$id');
                          readSQLite();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      );

  Future<Null> confirmDeleteAllData() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการจะลบรายการแก๊สทั้งหมดใช่ไหม ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.green,
                onPressed: () async {
                  Navigator.pop(context);
                  await SQLiteHelper().deleteAllData().then((value) {
                    readSQLite();
                  });
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                label: Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                label: Text(
                  'ยกเลิก',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddOrderButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15),
          width: 150,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.red,
            onPressed: () {
              orderThread();
            },
            label: Text(
              'สั่งซื้อ',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.add_shopping_cart_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> orderThread() async {
    DateTime dateTime = DateTime.now();
    // print(dateTime.toString());
    String order_date_time = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    String distance = cartModels[0].distance;
    String transport = cartModels[0].transport;
    List<String> gas_ids = List();
    List<String> gas_brand_ids = List();
    List<String> gas_size_ids = List();
    List<String> gas_brand_names = List();
    List<String> prices = List();
    List<String> amounts = List();
    List<String> sums = List();

    for (var model in cartModels) {
      gas_ids.add(model.gas_id);
      gas_brand_ids.add(model.gas_brand_id);
      gas_size_ids.add(model.gas_size_id);
      gas_brand_names.add(model.gas_brand_name);
      prices.add(model.price);
      amounts.add(model.amount);
      sums.add(model.sum);
    }
    String gas_id = gas_ids.toString();
    String gas_brand_id = gas_brand_ids.toString();
    String gas_size_id = gas_size_ids.toString();
    String gas_brand_name = gas_brand_names.toString();
    String price = prices.toString();
    String amount = amounts.toString();
    String sum = sums.toString();
    print(
        'orderDateTime == $order_date_time , distance ==> $distance, transport ==> $transport');
    print(
        'gas_id ==> $gas_id , gas_brand_id ==> $gas_brand_id, gas_size_id ==> $gas_size_id, gas_brand_name ==> $gas_brand_name, price ==> $price , amount ==> $amount , sum ==> $sum');
  }
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
