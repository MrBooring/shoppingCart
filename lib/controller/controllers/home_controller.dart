import 'package:appcart/controller/controllers/cart_controller.dart';
import 'package:appcart/model/data_models/temp%20static/temp_product_list.dart';
import 'package:appcart/model/data_models/transaction_model.dart';
import 'package:get/get.dart';

import '../../util/database_helper.dart';

class HomeController extends GetxController {
  var products = [].obs;
  var cartItems = [].obs;
  var transactionHistory = <TransactionModel>[].obs;
  CartController cartController = Get.put(CartController());

  @override
  void onInit() {
    // PermissionHandler().requestPermissions();
    products.addAll(constantProducts);
    fetchTransactions();
    super.onInit();
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    // if (await PermissionHandler().requestPermissions()) {
    final dbHelper = DatabaseHelper.instance;
    var trans = await dbHelper.getTransactions();
    transactionHistory.clear();
    transactionHistory.addAll(trans);
    return transactionHistory;
    // } else {
    //   return [];
    // }
  }
}
