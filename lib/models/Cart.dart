import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'Product.dart';

class CartItem {
  final Product product;
  final int numOfItems;
  final double price;

  CartItem({
    @required this.product,
    @required this.numOfItems,
    this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {...items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.numOfItems;
    });
    return total;
  }
}

//demo data for cart

List<CartItem> demoCarts = [
  CartItem(
    product: demoProducts[0],
    numOfItems: 2,
    price: 2,
  ),
  CartItem(
    product: demoProducts[1],
    numOfItems: 1,
    price: 2,
  ),
  CartItem(
    product: demoProducts[3],
    numOfItems: 1,
    price: 2,
  ),
];
