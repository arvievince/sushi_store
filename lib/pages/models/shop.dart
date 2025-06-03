import 'package:flutter/material.dart';
import 'package:sushi_store/pages/models/food_model.dart';

class Shop extends ChangeNotifier {

  final List <FoodModel> _foodMenu = [
    FoodModel(
        name: 'Salmon',
        imagePath: 'lib/images/sushi_1.png',
        price: 349.00,
        rating: 4.5),
    FoodModel(
        name: 'Tuna',
        imagePath: 'lib/images/tuna.png',
        price: 245.00,
        rating: 4.3),
    FoodModel(
        name: 'Nigiri',
        imagePath: 'lib/images/nigiri.png',
        price: 275.00,
        rating: 4.6),
    FoodModel(
        name: 'Assorted',
        imagePath: 'lib/images/assorted.png',
        price: 899.00,
        rating: 4.4)
  ];

  List<FoodModel> _cart = [];

  List<FoodModel> get cart => _cart;
  List<FoodModel> get foodMenu => _foodMenu;

  void addToCart(FoodModel foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  void removeFromCart(FoodModel foodItem) {
    _cart.remove(foodItem);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
  
}