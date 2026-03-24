import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';

class ChangePasswordNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  ChangePasswordNotifier() {
    _loadDummyData();
    newPasswordController.addListener(notifyListeners);
  }

  void _loadDummyData() {
    emailController.text = "abdulrahman@email.com";
  }

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible = !isCurrentPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  String? validatePassword(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Password is required";
    if (text.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String? validateConfirmPassword(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Confirm password is required";
    if (text != newPasswordController.text.trim()) {
      return "Passwords do not match";
    }
    return null;
  }

  double get passwordStrength {
    final text = newPasswordController.text.trim();
    if (text.isEmpty) return 0.0;
    if (text.length < 6) return 0.25;
    if (text.length < 8) return 0.50;
    if (text.length < 10) return 0.75;
    return 1.0;
  }

  String get passwordStrengthText {
    final strength = passwordStrength;
    if (strength <= 0.25) return "Weak";
    if (strength <= 0.50) return "Fair";
    if (strength <= 0.75) return "Good";
    return "Strong";
  }

  Color get passwordStrengthColor {
    final strength = passwordStrength;
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.50) return Colors.orange;
    if (strength <= 0.75) return Colors.blue;
    return Colors.green;
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> savePassword(BuildContext context) async {
    if (!validateAndSave()) return;

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password changed successfully"),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}