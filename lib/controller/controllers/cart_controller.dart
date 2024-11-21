import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/data_models/cart_item.dart';
import '../../model/data_models/discount.dart';
import '../../model/data_models/product_model.dart';
import '../../model/data_models/temp static/temp_discount_list.dart';
import '../../model/data_models/transaction_model.dart';
import '../../util/database_helper.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  Discount selectedDiscount = Discount(code: "", description: "No Discount Applied", percentage: 0.0, minAmount: 0, offerType: OfferType.percentageOff);
  var disMessage = "".obs;
  var cartTotal = 0.0.obs;
  var withDiscount = 0.0.obs;
  var isCodeApplied = false.obs;
  var savedAmount = 0.0.obs;

  final TextEditingController discountCodeController = TextEditingController();

  @override
  void onInit() {
    resetDiscount();
    calculateTotal();

    super.onInit();
  }

  void resetDiscount() {
    disMessage.value = "";
    isCodeApplied.value = false;
    selectedDiscount = Discount(code: "", description: "No Discount Applied", percentage: 0.0, minAmount: 0, offerType: OfferType.percentageOff);
    isCodeApplied.value = false;
  }

  void addToCart(Product product) {
    final existing = cartItems.firstWhereOrNull((item) => item.cartId == product.id);
    if (existing != null) {
      existing.quantity++;
    } else {
      cartItems.add(CartItem(cartId: product.id, quantity: 1, product: product));
    }
    calculateTotal();
    Get.snackbar("Item added to Cart", "${product.name} added to cart");
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.cartId == productId);
    calculateTotal();
  }

  void updateQuantity(int productId, int quantity) {
    final existing = cartItems.firstWhereOrNull((item) => item.cartId == productId);
    if (existing != null) {
      if ((existing.quantity + quantity) >= 1) {
        existing.quantity += quantity;
      } else {
        removeFromCart(productId);
      }
    }
    calculateTotal();
    cartItems.refresh();
  }

  void applyDiscountCode(String code) {
    if (code.isEmpty) {
      resetDiscount();
      return;
    }

    Discount? discount = discounts.firstWhereOrNull((element) => element.code == code);

    if (discount != null) {
      if (discount.offerType == OfferType.percentageOff) {
        if (discount.minAmount <= cartTotal.value) {
          selectedDiscount = discount;
          disMessage.value = selectedDiscount.description;
          isCodeApplied.value = true;
        } else {
          var need = cartTotal.value - discount.minAmount;
          resetDiscount();
          isCodeApplied.value = false;
          disMessage.value = "Add \$${need.abs()} worth more of items to apply this code";
        }
      } else if (discount.offerType == OfferType.buyOneGetOneFree) {
        bool eligibleForBOGO = false;
        for (var item in cartItems) {
          if (item.quantity >= 2) {
            eligibleForBOGO = true;
            break;
          }
        }

        if (eligibleForBOGO) {
          selectedDiscount = discount;
          disMessage.value = selectedDiscount.description;
          isCodeApplied.value = true;
        } else {
          resetDiscount();
          isCodeApplied.value = false;
          disMessage.value = "Add at least 2 items of the same product to apply Buy 2, Get 1 Free";
        }
      }
    } else {
      resetDiscount();
      isCodeApplied.value = false;
      disMessage.value = "Invalid or Expired Code";
    }

    calculateTotal();
  }

  void calculateTotal() {
    double totalWithoutDiscount = cartItems.fold(0.0, (sum, item) {
      if (selectedDiscount.offerType == OfferType.buyOneGetOneFree && item.quantity >= 2) {
        // Buy 2, Get 1 Free logic
        return sum + item.product.price * (item.quantity - (item.quantity ~/ 3));
      } else {
        return sum + (item.product.price * item.quantity);
      }
    });

    // totalWithoutDiscount
    cartTotal.value = totalWithoutDiscount;

    // Apply discount logic
    double totalWithDiscount = totalWithoutDiscount;

    // Check if there's a percentage-based discount
    if (selectedDiscount.offerType == OfferType.percentageOff && cartTotal.value >= selectedDiscount.minAmount) {
      totalWithDiscount = totalWithoutDiscount * (1 - selectedDiscount.percentage / 100);
    }

    // Calculate the amount saved (savedAmount)
    savedAmount.value = totalWithoutDiscount - totalWithDiscount;

    // Set the total with discount
    withDiscount.value = totalWithDiscount;

    // Log for debugging
  }

  Future<void> saveTransaction() async {
    // if (await PermissionHandler().requestPermissions()) {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    final dbHelper = DatabaseHelper.instance;

    final transaction = TransactionModel(
      date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      total: cartTotal.value,
      discount: savedAmount.value,
      items: cartItems
          .map((item) => {
                'id': item.cartId,
                'name': item.product.name,
                'price': item.product.price,
                'quantity': item.quantity,
              })
          .toList()
          .toString(),
    );

    await dbHelper.insertTransaction(transaction);
    cartItems.clear(); // Clear the cart after checkout
    resetDiscount(); // Reset the discount

    Get.close(3);
    Get.snackbar("Success", "Transaction saved successfully!");
    // } else {
    //   return;
    // }
  }
}
