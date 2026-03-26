import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/settings/change_password_request.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/utils/utility/encrypt.dart';
import 'package:smart_lock_app/utils/widgets/custom_toast.dart';

class ChangePasswordNotifier extends BaseChangeNotifier with CommonFunctions {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  ChangePasswordNotifier() {
    _loadUserData();
    newPasswordController.addListener(_onPasswordChanged);
  }

  void _loadUserData() {
    getSavedUser();
    emailController.text = user?.email ?? "";
  }

  void _onPasswordChanged() {
    notifyListeners();
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

  String? validateCurrentPassword(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "Current password is required";
    }

    return null;
  }

  String? validatePassword(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "New password is required";
    }
    if (text.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return "Must include at least 1 uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return "Must include at least 1 number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]').hasMatch(text)) {
      return "Must include at least 1 special character";
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "Confirm password is required";
    }
    if (text != newPasswordController.text.trim()) {
      return "Passwords do not match";
    }

    return null;
  }

  double get passwordStrength {
    final text = newPasswordController.text.trim();
    if (text.isEmpty) return 0.0;

    int score = 0;
    if (text.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(text)) score++;
    if (RegExp(r'[0-9]').hasMatch(text)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\$begin:math:display$$end:math:display$~`]').hasMatch(text)) score++;

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

    final email = emailController.text.trim();
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty) {
      ToastHelper.showError("Email is missing", context: context);
      return;
    }

    if (currentPassword.isEmpty) {
      ToastHelper.showError("Current password is required", context: context);
      return;
    }

    if (newPassword.isEmpty) {
      ToastHelper.showError("New password is required", context: context);
      return;
    }

    if (confirmPassword.isEmpty) {
      ToastHelper.showError("Confirm password is required", context: context);
      return;
    }

    if (newPassword != confirmPassword) {
      ToastHelper.showError("Passwords do not match", context: context);
      return;
    }

    FocusScope.of(context).unfocus();
    isLoading = true;
    notifyListeners();

    try {
      final request = ChangePasswordRequest(
        tenantId: user?.tenantId ?? 0,
        oldPassword: encryptAES(currentPassword),
        newPassword: encryptAES(newPassword),
      );

      final result = await CommonRepository.instance.apiChangePassword(request);

      if (result is CommonResponse && result.success == true) {
        if (!context.mounted) return;

        ToastHelper.showSuccess(
          result.message ?? "Password changed successfully",
          context: context,
        );

        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        notifyListeners();

        Navigator.pop(context);
      } else if (result is ErrorResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Failed to change password",
          context: context,
        );
      } else if (result is CommonResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Failed to change password",
          context: context,
        );
      } else {
        if (!context.mounted) return;
        ToastHelper.showError(
          "Failed to change password",
          context: context,
        );
      }
    } catch (_) {
      if (!context.mounted) return;
      ToastHelper.showError(
        "Something went wrong",
        context: context,
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
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}