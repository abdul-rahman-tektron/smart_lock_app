
import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';

class LanguageNotifier extends BaseChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void switchLanguage(String langCode) {
    if (langCode == 'ar') {
      _locale = const Locale('ar');
    } else {
      _locale = const Locale('en');
    }
    notifyListeners();
  }
}
