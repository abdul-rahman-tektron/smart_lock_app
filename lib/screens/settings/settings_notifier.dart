import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/notifier/user_cache_notifier.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';

class SettingsNotifier extends BaseChangeNotifier {
  bool pushNotifications = true;
  bool biometricLogin = false;

  SettingsNotifier(BuildContext context);

  void togglePushNotifications(bool value) {
    pushNotifications = value;
    notifyListeners();
  }

  void toggleBiometricLogin(bool value) {
    biometricLogin = value;
    notifyListeners();
  }

  Future<void> logoutFunctionality(BuildContext context) async {
    await HiveStorageService.clearOnLogout();
    await context.read<UserCacheNotifier>().clearUser();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
          (route) => false,
    );
  }
}