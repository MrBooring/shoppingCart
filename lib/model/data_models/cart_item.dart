import 'package:appcart/model/data_models/product_model.dart';

class CartItem {
  final int cartId;
  int quantity;
  Product product;

  CartItem({
    required this.cartId,
    required this.quantity,
    required this.product,
  });

  // Convert a CartItem to a map (for database operations)
  Map<String, dynamic> toMap() {
    return {'cartId': cartId, 'quantity': quantity, 'product': product};
  }

  // Convert a map to a CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      cartId: map['cartId'],
      quantity: map['quantity'],
      product: map['product'],
    );
  }
}
