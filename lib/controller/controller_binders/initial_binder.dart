import 'package:appcart/controller/controllers/cart_controller.dart';
import 'package:appcart/controller/controllers/home_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
  }
}
