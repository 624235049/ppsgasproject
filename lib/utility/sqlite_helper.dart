import 'dart:convert';

import 'package:ppsgasproject/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'gasrproject.db';
  String tableDatabase = 'orderdetailTable';
  int version = 1;

  final String idColumn = 'id';
  final String gas_id = 'gas_id';
  final String gas_brand_id = 'gas_brand_id';
  final String gas_brand_name = 'gas_brand_name';
  final String gas_size_id = 'gas_size_id';
  final String price = 'price';
  final String amount = 'amount';
  final String sum = 'sum';
  final String distance = 'distance';
  final String transport = 'transport';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $gas_id TEXT, $gas_brand_id TEXT,$gas_brand_name TEXT,$gas_size_id TEXT,$price TEXT,$amount TEXT,$sum TEXT,$distance TEXT,$transport TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> insertDataToSQLite(CartModel cartModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        tableDatabase,
        cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<CartModel>> readAllDataFormSQLite() async {
    Database database = await connectedDatabase();
    List<CartModel> cartModels = List();

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      CartModel cartModel = CartModel.fromJson(map);
      cartModels.add(cartModel);
    }

    return cartModels;
  }
}
