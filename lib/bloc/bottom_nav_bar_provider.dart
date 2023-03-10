import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  bool _isHideTabBar = false;

  bool get isHideTabBar => _isHideTabBar;

  void showTabBarStatus() {
    _isHideTabBar = false;
    notifyListeners();
  }

  void hideTabBarStatus() {
    _isHideTabBar = true;
    notifyListeners();
  }
}
