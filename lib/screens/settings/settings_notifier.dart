import 'package:smart_lock_app/core/base/base_notifier.dart';

class SettingsNotifier extends BaseChangeNotifier {
  bool pushNotifications = true;
  bool biometricLogin = false;

  String tenantName = "Abdul Rahman";
  String unitName = "Unit A-1204 • Aldar Residence";
  String mobileNumber = "+971 50 123 4567";
  String email = "abdulrahman@email.com";

  void togglePushNotifications(bool value) {
    pushNotifications = value;
    notifyListeners();
  }

  void toggleBiometricLogin(bool value) {
    biometricLogin = value;
    notifyListeners();
  }
}