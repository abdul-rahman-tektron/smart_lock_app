import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/utils/routes.dart';

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
      otpControllers[index].selection = const TextSelection.collapsed(offset: 1);
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

  String get enteredOtp {
    return otpControllers.map((c) => c.text).join();
  }

  Future<void> verifyOtp(BuildContext context) async {
    final otp = enteredOtp;

    if (otp.length != otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete OTP")),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      /// TODO:
      /// Replace with your real verify OTP API call
      /// send:
      /// email
      /// otp

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP verified successfully")),
      );

      Navigator.pushNamed(
        context,
        AppRoutes.resetPassword,
        arguments: {
          "email": email,
          "otp": otp,
        },
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect OTP")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendOtp() async {
    isResendEnabled = false;
    secondsRemaining = 30;
    notifyListeners();

    try {
      /// TODO:
      /// Replace with your real resend OTP API call
      /// send:
      /// email

      _startResendCountdown();
    } catch (e) {
      isResendEnabled = true;
      notifyListeners();
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