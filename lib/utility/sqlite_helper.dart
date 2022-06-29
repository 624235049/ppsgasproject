import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'gasrproject.db';
  String tableDatabase = 'orderdetailTable';
  int version = 1;

  final String idColumn = 'id';
  final String gas_id = 'gas_id';
  final String gas_brand_id = 'gas_brand_id';
  final String gas_zie_id = 'gas_zie_id';
  final String price = 'price';
  final String qty = 'qty';
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
            'CREATE $tableDatabase Test ($idColumn INTEGER PRIMARY KEY, $gas_id TEXT, $gas_brand_id TEXT, $gas_zie_id TEXT, $price TEXT, $qty TEXT, $amount TEXT, $sum TEXT, $distance TEXT, $transport)'),
        version: version);
  }
}
