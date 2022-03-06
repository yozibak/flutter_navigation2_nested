import 'package:flutter/material.dart';
import 'package:nested_nav2/models.dart';

class GlobalAppState extends ChangeNotifier {
  bool _isLoggedIn;
  get isLoggedIn => _isLoggedIn;
  GlobalAppState() : _isLoggedIn = false;
  void logIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

// use riverpod provider for this list
final List<Food> foods = [
  Food('Banana', 200),
  Food('Ramen', 800),
  Food('Pizza', 1300),
];

class FoodTabState extends ChangeNotifier {
  Food? _selectedFood;

  FoodTabState();

  Food? get selectedFood => _selectedFood;

  void selectFood(Food food) {
    _selectedFood = food;
    notifyListeners();
  }

  void selectFoodById(int foodIndex) {
    _selectedFood = foods[foodIndex];
    notifyListeners();
  }

  void unSelectFood() {
    _selectedFood = null;
    notifyListeners();
  }
}
