class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String? discountDetails;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.discountDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'discountDetails': discountDetails,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      discountDetails: map['discountDetails'],
    );
  }
}
