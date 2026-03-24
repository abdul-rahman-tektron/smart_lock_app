import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/utils/routes.dart';

class ResetPasswordNotifier extends BaseChangeNotifier {
  final String? email;
  final String? otp;

  ResetPasswordNotifier({
    this.email,
    this.otp,
  }) {
    emailController.text = email ?? "";
    newPasswordController.addListener(_onPasswordChanged);
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  void _onPasswordChanged() {
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

    if (text.isEmpty) return "";
    if (text.length < 8) return "";
    if (!RegExp(r'[A-Z]').hasMatch(text)) return "";
    if (!RegExp(r'[0-9]').hasMatch(text)) return "";
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\$begin:math:display$$end:math:display$~`]').hasMatch(text)) return "";

    return null;
  }

  String? validateConfirmPassword(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) return "";
    if (text != newPasswordController.text.trim()) return "";

    return null;
  }

  double get passwordStrength {
    final text = newPasswordController.text.trim();

    if (text.isEmpty) return 0.0;

    int score = 0;

    if (text.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(text)) score++;
    if (RegExp(r'[0-9]').hasMatch(text)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]').hasMatch(text)) score++;

    return score / 4;
  }

  String get passwordStrengthText {
    final strength = passwordStrength;

    if (strength == 0) return "Weak";
    if (strength <= 0.50) return "Fair";
    if (strength <= 0.75) return "Good";
    return "Strong";
  }

  Color get passwordStrengthColor {
    final strength = passwordStrength;

    if (strength == 0) return AppColors.error;
    if (strength <= 0.50) return AppColors.warning;
    if (strength <= 0.75) return const Color(0xFF1E88E5);
    return AppColors.success;
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
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      /// TODO:
      /// call your reset password API here with:
      /// email
      /// otp
      /// newPasswordController.text.trim()

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset successfully"),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (route) => false,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to reset password. Try again."),
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    newPasswordController.removeListener(_onPasswordChanged);
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}