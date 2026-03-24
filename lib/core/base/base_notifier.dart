import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';

abstract class BaseChangeNotifier with ChangeNotifier {
  // ----- Private Fields -----
  bool _disposed = false;

  UserData? _user;

  UserData? get user => _user;

  set user(UserData? data) {
    if(_user == data) return;
    _user = data;
    notifyListeners();
  }

  // ----- Safe Notify -----
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }


  void getSavedUser() {
    final userJson = HiveStorageService.getUserData();

    final map = jsonDecode(userJson ?? "") as Map<String, dynamic>;
    user = UserData.fromJson(map);
  }

  // ----- Optional Logger -----
  void logPrint(Object? object) {
    const int chunkSize = 1000;
    final text = object?.toString() ?? '';
    for (int i = 0; i < text.length; i += chunkSize) {
      debugPrint(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }
}
