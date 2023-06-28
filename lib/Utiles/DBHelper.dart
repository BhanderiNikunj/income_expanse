import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static DBHelper dbHelper = DBHelper._();

  DBHelper._();

  Database? database;

  Future<Database> ChackDB() async {
    if (database == null) {
      print("--------------");
      return await initDB();
    } else {
      print("-------");
      return database!;
    }
  }

  Future<Future<Database>> initDB() async {
    print("============");
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(
      directory.path,
      "income.db",
    );

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String quary =
            "CREATE TABLE income (id INTEGER PRIMARY KEY,title TEXT , resion TEXT , price INTEGER , incomeExpanse INTEGER)";

        db.execute(quary);
      },
    );
  }

  // Income Expanse
  Future<void> insertIncomeExpanse({
    required title,
    required resion,
    required price,
    required incomeExpanse,
  }) async {
    database = await ChackDB();

    database!.insert("income", {
      "title": title,
      "resion": resion,
      "price": price,
      "incomeExpanse": incomeExpanse,
    });
  }

  Future<List<Map>> readIncome() async {
    database = await ChackDB();

    String quary = "SELECT * FROM income";

    List<Map> Income = await database!.rawQuery(quary);

    return Income;
  }

  Future<void> deleteIncome({
    required id,
  }) async {
    database = await ChackDB();

    database!.delete(
      "income",
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<void> updateIncome({
    required id,
    required title,
    required resion,
    required price,
    required incomeExpanse,
  }) async {
    database = await ChackDB();

    database!.update(
      "income",
      {
        "title": title,
        "resion": resion,
        "price": price,
        "incomeExpanse": incomeExpanse,
      },
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<List<Map>> filterData({
    required status,
  }) async {
    database = await ChackDB();

    if (status == 1) {
      String quary = "SELECT * FROM income WHERE incomeExpanse=0";
      List<Map> Income = await database!.rawQuery(quary);
      return Income;
    } else {
      String quary = "SELECT * FROM income WHERE incomeExpanse=1";
      List<Map> Expanse = await database!.rawQuery(quary);
      return Expanse;
    }
  }

  Future<List<Map<String, Object?>>> totalPrice() async {
    String quary = "SELECT SUM(price) as incomeExpanse=0 FROM income";
    var total = await database?.rawQuery(quary);
    print(total!.length);
    return total;
  }
}
