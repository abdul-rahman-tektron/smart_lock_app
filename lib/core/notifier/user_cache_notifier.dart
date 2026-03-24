import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';

class UserCacheNotifier extends ChangeNotifier {
  UserData? user;

  UserCacheNotifier() {
    loadUser();
  }

  void loadUser() {
    try {
      final userJson = HiveStorageService.getUserData();

      if (userJson != null && userJson.isNotEmpty) {
        user = UserData.fromJson(jsonDecode(userJson));
      }
    } catch (_) {
      user = null;
    }

    notifyListeners();
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }
}