import 'package:api_exam/Utiles/DBHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddDataControllor extends GetxController {
  RxInt checkIncome = 0.obs;
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtResion = TextEditingController();
  TextEditingController txtPrice = TextEditingController();

  void addIncomeExpanse({
    required title,
    required resion,
    required price,
    required incomeExpanse,
  }) {
    DBHelper.dbHelper.insertIncomeExpanse(
      title: title,
      resion: resion,
      price: price,
      incomeExpanse: incomeExpanse,
    );
  }

  void updateIncome({
    required id,
    required title,
    required resion,
    required price,
    required incomeExpanse,
  }) {
    DBHelper.dbHelper.updateIncome(
      id: id,
      title: title,
      resion: resion,
      price: price,
      incomeExpanse: incomeExpanse,
    );
  }

  Future<List<Map>> readIncome() async {
    return await DBHelper.dbHelper.readIncome();
  }
}
