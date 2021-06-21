import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  bool isFavourite, isPopular;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.images,
    @required this.colors,
    @required this.price,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
  });

  Product copyWith({
    String id,
    String title,
    String description,
    double price,
    double rating,
    String images,
    Color colors,
    bool isFavourite,
    bool isPopular,
  }) {
    return Product(
      //if id is null then set it eual to this.id
      //?? = if null
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      isFavourite: isFavourite ?? this.isFavourite,
      isPopular: isPopular ?? this.isPopular,
      colors: colors ?? this.colors,
    );
  }

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://shop-app-ad2bb-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavourite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}

//demo prodcut
List<Product> demoProducts = [
  Product(
    id: '1',
    images: [
      "assets/images/image-1-front.png",
      "assets/images/image-1-back.png",
      "assets/images/image-1-side.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Metal temple eyeglasses",
    price: 64.99,
    description:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum',
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/image-2-front.jpg",
      "assets/images/image-2-back.jpg",
      "assets/images/image-2-side.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Thin metal acetate rim",
    price: 50.5,
    description:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum',
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: '3',
    images: [
      "assets/images/image-3-front.png",
      "assets/images/image-3-back.png",
      "assets/images/image-3-side.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Metal bar frame",
    price: 36.55,
    description:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum',
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
];
