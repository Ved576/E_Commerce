import 'package:flutter/cupertino.dart';

import 'products.dart';

class shopModel extends ChangeNotifier {
  //display products

  final List<Products> _shop = [
    //product1
    Products(
      name: "The Chillin Tee",
      description:
          ' Premium soft-touch cotton for a relaxed, refined, and effortless fit.',
      price: 1,
      imgPath: 'assets/p1.webp',
    ),

    //product2
    Products(
      name: 'The Essential Navy Shirt',
      description: 'Timeless elegance, impeccably tailored in premium fabric for a sharp fit.',
      price: 2,
      imgPath: 'assets/p2.webp',
    ),

    //product3
    Products(
      name: 'The Textured Knit Shirt',
      description: 'A uniquely textured knit for a structured yet comfortable modern fit.',
      price: 1,
      imgPath: 'assets/p3.webp',
    ),

    //product4
    Products(
      name: 'The "Head In The Clouds" Tee',
      description: 'Premium heavyweight cotton with a structured, oversized fit and statement graphic.',
      price: 1,
      imgPath: 'assets/p4.webp',
    ),
  ];

  //user cart
  List<Products> _cart = [];

  //get product list
  List<Products> get shop => _shop;

  //get user cart

  List<Products> get cart => _cart;

  //add items to cart
  void addToCart(Products item) {
    _cart.add(item);
    notifyListeners();
  }

  //remove item from cart
  void removeFromCart(Products item) {
    _cart.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
