import 'package:api_exam/Utiles/DBHelper.dart';
import 'package:get/get.dart';

class HomeControllor extends GetxController {
  RxInt checkFilter = 0.obs;

  Future<List<Map>> readIncome() async {
    return await DBHelper.dbHelper.readIncome();
  }

  void deleteIncome({
    required id,
  }) {
    DBHelper.dbHelper.deleteIncome(
      id: id,
    );
  }

  Future<List<Map>> filterData({
    required status,
  }) {
    return DBHelper.dbHelper.filterData(
      status: status,
    );
  }

}
