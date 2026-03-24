import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/screens/home/home_screen.dart';
import 'package:smart_lock_app/screens/settings/settings_screen.dart';

class BottomScreenNotifier extends BaseChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  BottomScreenNotifier(int? currentIndex) {
    initNotifier();
    _currentIndex = currentIndex ?? 0;
  }

  Future<void> initNotifier() async {

  }

  void changeTab(int index, {String? category}) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget get currentScreen {
    return [
      HomeScreen(),
      SettingsScreen(),
    ][_currentIndex];
  }
}

