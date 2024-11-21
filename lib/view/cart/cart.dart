import 'package:appcart/model/data_models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controllers/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final CartItem cartItem = controller.cartItems[index];
                  return ListTile(
                    title: Text(cartItem.product.name),
                    subtitle: Text('Quantity: ${cartItem.quantity}, Price: \$${cartItem.product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Ensures the buttons fit within the trailing area
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            controller.updateQuantity(cartItem.product.id, -1);
                          },
                        ),
                        Text('${cartItem.quantity}', style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            controller.updateQuantity(cartItem.product.id, 1);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            controller.removeFromCart(cartItem.product.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Discount Code Input and Apply Button
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.discountCodeController,
                          decoration: InputDecoration(
                            labelText: 'Enter Discount Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          controller.applyDiscountCode(controller.discountCodeController.text.trim()); // Apply discount
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Display applied discount message
                  Text(
                    controller.disMessage.value,
                    style: TextStyle(color: controller.isCodeApplied.value ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            // Total after applying discount
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '\$${controller.cartTotal.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: controller.savedAmount.value != 0 ? TextDecoration.lineThrough : null,
                      decorationThickness: 2.0,
                    ),
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 20), // Adding a space of 20 pixels
                  ),
                  TextSpan(
                    text: controller.savedAmount.value != 0 ? ' Save: ${controller.savedAmount.value}' : null,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            controller.savedAmount.value != 0 ? Text("Total: \$${controller.withDiscount.value.toStringAsFixed(2)}") : const SizedBox(),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/checkout");
              },
              child: const Text('Checkout'),
            ),
          ],
        );
      }),
    );
  }
}
