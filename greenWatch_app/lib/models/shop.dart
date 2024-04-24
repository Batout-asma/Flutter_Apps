import 'package:auth_app/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> shopList = [
    // product 1
    Product(
      name: "Product 1",
      price: 200.00,
      description: "some text here ...",
    ), // product 2
    Product(
      name: "Product 2",
      price: 100.00,
      description: "some text here ...",
    ), // product 3
    Product(
      name: "Product 3",
      price: 250.00,
      description: "some text here ...",
    ), // product 4
    Product(
      name: "Product 4",
      price: 150.00,
      description: "some text here ...",
    ),
  ];

// user cart
  List<Product> cartList = [];

// get product list
  List<Product> get shop => shopList;

// get user list
  List<Product> get cart => cartList;

// add items to cart
  void addToCart(Product item) {
    cartList.add(item);
    notifyListeners();
  }

// remove item from cart
  void removeFromCart(Product item) {
    cartList.remove(item);
    notifyListeners();
  }
}
