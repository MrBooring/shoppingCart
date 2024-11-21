
import 'package:appcart/model/data_models/product_model.dart';

List<Product> constantProducts = [
  Product(
    id: 1,
    name: 'Laptop',
    price: 800.0,
    quantity: 10,
    discountDetails: '{"type": "percentage", "value": 10}', // 10% off
  ),
  Product(
    id: 2,
    name: 'Smartphone',
    price: 500.0,
    quantity: 15,
    discountDetails: '{"type": "percentage", "value": 5}', // 5% off
  ),
  Product(
    id: 3,
    name: 'Headphones',
    price: 50.0,
    quantity: 20,
    discountDetails: '{"type": "buyXGetY", "x": 2, "y": 1}', // Buy 2 Get 1 Free
  ),
  Product(
    id: 4,
    name: 'Smartwatch',
    price: 150.0,
    quantity: 12,
    discountDetails: '{"type": "none"}', // No discount
  ),
  Product(
    id: 5,
    name: 'Gaming Console',
    price: 400.0,
    quantity: 5,
    discountDetails: '{"type": "percentage", "value": 15}', // 15% off
  ),
  Product(
    id: 6,
    name: 'Wireless Charger',
    price: 30.0,
    quantity: 25,
    discountDetails: '{"type": "buyXGetY", "x": 3, "y": 1}', // Buy 3 Get 1 Free
  ),
  Product(
    id: 7,
    name: 'External Hard Drive',
    price: 100.0,
    quantity: 10,
    discountDetails: '{"type": "percentage", "value": 10}', // 10% off
  ),
  Product(
    id: 8,
    name: 'Bluetooth Speaker',
    price: 60.0,
    quantity: 18,
    discountDetails: '{"type": "none"}', // No discount
  ),
  Product(
    id: 9,
    name: 'Camera',
    price: 300.0,
    quantity: 8,
    discountDetails: '{"type": "percentage", "value": 20}', // 20% off
  ),
  Product(
    id: 10,
    name: 'Keyboard and Mouse Combo',
    price: 40.0,
    quantity: 30,
    discountDetails: '{"type": "none"}', // No discount
  ),
];
