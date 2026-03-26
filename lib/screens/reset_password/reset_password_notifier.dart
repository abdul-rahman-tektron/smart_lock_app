import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/forgot_password/reset_password_request.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/widgets/custom_toast.dart';

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

    if (text.isEmpty) {
      return "Please enter a new password";
    }
    if (text.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return "Password must contain at least 1 uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return "Password must contain at least 1 number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?\":{}|<>_\-+=/\\[\]~`]').hasMatch(text)) {
      return "Password must contain at least 1 special character";
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "Please confirm your password";
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

    final currentEmail = emailController.text.trim();
    final currentOtp = otp?.trim() ?? "";
    final newPassword = newPasswordController.text.trim();

    if (currentEmail.isEmpty) {
      ToastHelper.showError("Email is missing", context: context);
      return;
    }

    if (currentOtp.isEmpty) {
      ToastHelper.showError("OTP is missing", context: context);
      return;
    }

    FocusScope.of(context).unfocus();
    isLoading = true;
    notifyListeners();

    try {
      final request = ResetPasswordRequest(
        email: currentEmail,
        otp: currentOtp,
        newPassword: newPassword,
      );

      final result = await CommonRepository.instance.apiResetPassword(request);

      if (result is CommonResponse && result.success == true) {
        if (!context.mounted) return;

        ToastHelper.showSuccess(
          result.message ?? "Password reset successfully",
          context: context,
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
              (route) => false,
        );
      } else if (result is ErrorResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Failed to reset password. Try again.",
          context: context,
        );
      } else if (result is CommonResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Failed to reset password. Try again.",
          context: context,
        );
      } else {
        if (!context.mounted) return;
        ToastHelper.showError(
          "Failed to reset password. Try again.",
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
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}