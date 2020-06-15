import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';

class DatabaseProvider {
  static const String Table_Basket = 'basket';
  static const String Column_Id = 'id';
  static const String ColumnBottleID = 'bottle_id';
  static const String ColumnSizeID = 'size_id';
  static const String ColumnCount = 'column_count';

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'tunywe.db'), version: 1,
        onCreate: (db, num) async {
      print('creating Table');
      await db.execute(
        "CREATE TABLE $Table_Basket ("
        "$Column_Id INTEGER PRIMARY KEY autoincrement,"
        "$ColumnBottleID TEXT,"
        "$ColumnSizeID TEXT,"
        "$ColumnCount INTEGER"
        ")",
      );
    });
  }

  Future<List<BasketItem>> getItems(BuildContext context) async {
    final db = await database;
    var items = await db.query(Table_Basket,
        columns: [Column_Id, ColumnBottleID, ColumnSizeID, ColumnCount]);
    List<BasketItem> basketList = new List();
    items.forEach((currentItem) {
      BasketItem item = BasketItem.fromMap(currentItem);
      basketList.add(item);
    });
    ViewModel viewModel = Provider.of<ViewModel>(context, listen: false);
    viewModel.basket = basketList;
    print('list gotten ' + basketList.length.toString());
    return basketList;
  }

  Future<BasketItem> insert(BasketItem item) async {
    final db = await database;
    print('bottle inserted');
    db.insert(Table_Basket, item.toMap());
    return item;
  }

  delete(BasketItem item) async {
    final db = await database;
    print('bottle deleted');
    db.delete(Table_Basket,
        where: '$ColumnBottleID', whereArgs: [item.bottleID]);
  }
}
