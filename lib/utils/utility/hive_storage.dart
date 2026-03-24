import 'package:hive/hive.dart';
import 'package:smart_lock_app/res/hive_keys.dart';

class HiveStorageService {
  HiveStorageService._();

  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('appBox');
  }

  static Future<void> setLanguageCode(String langCode) async {
    await _box.put(HiveKeys.languageCode, langCode);
  }

  static String? getLanguageCode() {
    return _box.get(HiveKeys.languageCode);
  }

  static Future<void> setIsLoggedIn(bool value) async {
    await _box.put(HiveKeys.isLoggedIn, value);
  }

  static bool getIsLoggedIn() {
    return _box.get(HiveKeys.isLoggedIn, defaultValue: false);
  }

  static Future<void> setUserData(String userJson) async {
    await _box.put(HiveKeys.userData, userJson);
  }

  static String? getUserData() {
    return _box.get(HiveKeys.userData);
  }

  static Future<void> setAccessToken(String token) async {
    await _box.put(HiveKeys.accessToken, token);
  }

  static String? getAccessToken() {
    return _box.get(HiveKeys.accessToken);
  }

  static Future<void> setRememberMe(String value) async {
    await _box.put(HiveKeys.rememberMe, value);
  }

  static String getRememberMe() {
    return _box.get(HiveKeys.rememberMe, defaultValue: false);
  }

  static Future<void> remove(String key) async {
    await _box.delete(key);
  }

  static Future<void> clear() async {
    await _box.clear();
  }

  static Future<void> clearOnLogout() async {
    final List<String> preserveKeys = [
      HiveKeys.languageCode,
      HiveKeys.rememberMe,
    ];

    final Map<String, dynamic> preservedData = {};

    for (final key in preserveKeys) {
      if (_box.containsKey(key)) {
        preservedData[key] = _box.get(key);
      }
    }

    await _box.clear();

    for (final entry in preservedData.entries) {
      await _box.put(entry.key, entry.value);
    }
  }
}