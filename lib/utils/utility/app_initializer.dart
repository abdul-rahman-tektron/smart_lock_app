import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeStorage();
    await _setSystemUi();
  }

  static Future<void> _initializeStorage() async {
    await Hive.initFlutter();
    await HiveStorageService.init();
  }

  static Future<void> _setSystemUi() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  }

  static Future<Map<String, dynamic>> loadUserData() async {
    final token = HiveStorageService.getAccessToken();
    final isLoggedIn = HiveStorageService.getIsLoggedIn();
    final userJson = HiveStorageService.getUserData();

    return {
      "token": token,
      "isLoggedIn": isLoggedIn,
      "userJson": userJson,
    };
  }
}