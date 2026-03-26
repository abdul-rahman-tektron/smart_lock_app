import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';

class UserCacheNotifier extends ChangeNotifier {
  UserData? user;
  int imageRefreshToken = 0;

  UserCacheNotifier() {
    loadUser();
  }

  void loadUser() {
    try {
      final userJson = HiveStorageService.getUserData();

      if (userJson != null && userJson.isNotEmpty) {
        user = UserData.fromJson(jsonDecode(userJson));
      } else {
        user = null;
      }
    } catch (_) {
      user = null;
    }

    notifyListeners();
  }

  Future<void> reloadUser() async {
    loadUser();
  }

  Future<void> setUser(UserData? newUser) async {
    user = newUser;

    if (newUser != null) {
      await HiveStorageService.setUserData(jsonEncode(newUser.toJson()));
    } else {
      await HiveStorageService.setUserData("");
    }

    notifyListeners();
  }

  void refreshProfileImage() {
    imageRefreshToken = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
  }

  Future<void> clearUser() async {
    user = null;
    notifyListeners();
  }
}