import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controllers/cart_controller.dart';
import '../../model/data_models/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final CartItem cartItem = cartController.cartItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(cartItem.product.name),
                      subtitle: Text('Quantity: ${cartItem.quantity}, Price: \$${cartItem.product.price}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Text("Total: \$${cartController.cartTotal.value.toStringAsFixed(2)}", style: Theme.of(context).textTheme.titleSmall)),
                  Obx(() => Text("Discount: \$${cartController.savedAmount.value.toStringAsFixed(2)}", style: Theme.of(context).textTheme.titleSmall)),
                  Obx(() => Text("Final Total: \$${cartController.withDiscount.value.toStringAsFixed(2)}", style: Theme.of(context).textTheme.titleMedium)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await cartController.saveTransaction();
                    },
                    child: const Text("Confirm Purchase"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
