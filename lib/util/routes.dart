import 'package:appcart/view/cart/cart.dart';
import 'package:appcart/view/checkout/checkout.dart';
import 'package:appcart/view/home/home_screen.dart';
import 'package:appcart/view/home/transactions_history.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: '/cart',
    page: () => const CartScreen(),
  ),
  GetPage(
    name: '/checkout',
    page: () => const CheckoutScreen(),
  ),
  GetPage(
    name: '/transaction',
    page: () => TransactionListScreen(),
  ),
];
