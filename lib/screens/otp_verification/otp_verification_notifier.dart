import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/forgot_password/forgot_password_request.dart';
import 'package:smart_lock_app/core/model/forgot_password/otp_verify_request.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/widgets/custom_toast.dart';

class OtpVerificationNotifier extends BaseChangeNotifier {
  final String? email;

  OtpVerificationNotifier({this.email}) {
    _initOtpFields();
    _startResendCountdown();
  }

  final int otpLength = 6;

  late final List<TextEditingController> otpControllers;
  late final List<FocusNode> focusNodes;

  bool isResendEnabled = false;
  bool isLoading = false;
  int secondsRemaining = 30;

  Timer? _timer;

  void _initOtpFields() {
    otpControllers = List.generate(
      otpLength,
          (_) => TextEditingController(),
    );

    focusNodes = List.generate(
      otpLength,
          (_) => FocusNode(),
    );
  }

  void onOtpTap(int index) {
    final controller = otpControllers[index];
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
  }

  void onOtpChange(String value, int index) {
    if (value.length > 1) {
      otpControllers[index].text = value.substring(value.length - 1);
      otpControllers[index].selection =
      const TextSelection.collapsed(offset: 1);
    }

    if (value.isNotEmpty && index < otpLength - 1) {
      FocusScope.of(focusNodes[index].context!).requestFocus(
        focusNodes[index + 1],
      );

      final nextController = otpControllers[index + 1];
      nextController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: nextController.text.length,
      );
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(focusNodes[index].context!).requestFocus(
        focusNodes[index - 1],
      );

      final previousController = otpControllers[index - 1];
      previousController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: previousController.text.length,
      );
    }

    notifyListeners();
  }

  String get enteredOtp => otpControllers.map((c) => c.text).join();

  Future<void> verifyOtp(BuildContext context) async {
    final otp = enteredOtp;
    final currentEmail = email?.trim() ?? "";

    if (currentEmail.isEmpty) {
      ToastHelper.showError("Email is missing", context: context);
      return;
    }

    if (otp.length != otpLength) {
      ToastHelper.showError("Please enter the complete OTP", context: context);
      return;
    }

    FocusScope.of(context).unfocus();
    isLoading = true;
    notifyListeners();

    try {
      final request = OtpVerifyRequest(
        email: currentEmail,
        otp: otp,
      );

      final result = await CommonRepository.instance.apiOTPVerification(request);

      if (result is CommonResponse && result.success == true) {
        if (!context.mounted) return;

        ToastHelper.showSuccess(
          result.message ?? "OTP verified successfully",
          context: context,
        );

        Navigator.pushNamed(
          context,
          AppRoutes.resetPassword,
          arguments: {
            "email": currentEmail,
            "otp": otp,
          },
        );
      } else if (result is ErrorResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Incorrect OTP",
          context: context,
        );
      } else if (result is CommonResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Incorrect OTP",
          context: context,
        );
      } else {
        if (!context.mounted) return;
        ToastHelper.showError(
          "Failed to verify OTP",
          context: context,
        );
      }
    } catch (_) {
      if (!context.mounted) return;
      ToastHelper.showError("Something went wrong", context: context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    final currentEmail = email?.trim() ?? "";

    if (currentEmail.isEmpty) {
      ToastHelper.showError("Email is missing", context: context);
      return;
    }

    isResendEnabled = false;
    secondsRemaining = 30;
    notifyListeners();

    try {
      final result = await CommonRepository.instance.apiForgotPassword(
        ForgotPasswordRequest(email: currentEmail),
      );

      if (result is CommonResponse && result.success == true) {
        if (context.mounted) {
          ToastHelper.showSuccess(
            result.message ?? "OTP sent successfully",
            context: context,
          );
        }
        _startResendCountdown();
      } else if (result is ErrorResponse) {
        isResendEnabled = true;
        notifyListeners();

        if (context.mounted) {
          ToastHelper.showError(
            result.message ?? "Failed to resend OTP",
            context: context,
          );
        }
      } else if (result is CommonResponse) {
        isResendEnabled = true;
        notifyListeners();

        if (context.mounted) {
          ToastHelper.showError(
            result.message ?? "Failed to resend OTP",
            context: context,
          );
        }
      } else {
        isResendEnabled = true;
        notifyListeners();

        if (context.mounted) {
          ToastHelper.showError(
            "Failed to resend OTP",
            context: context,
          );
        }
      }
    } catch (_) {
      isResendEnabled = true;
      notifyListeners();

      if (context.mounted) {
        ToastHelper.showError("Something went wrong", context: context);
      }
    }
  }

  void _startResendCountdown() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        isResendEnabled = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }
}