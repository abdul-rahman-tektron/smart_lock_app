import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/login/login_request.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/core/model/login/remember_me.dart';
import 'package:smart_lock_app/core/notifier/user_cache_notifier.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/res/strings.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/utility/encrypt.dart';
import 'package:smart_lock_app/utils/utility/env.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';
import 'package:smart_lock_app/utils/widgets/custom_toast.dart';

class LoginNotifier extends ChangeNotifier with CommonFunctions {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isPasswordVisible = false;
  bool isLoading = false;

  String appVersion = '--';
  String buildNumber = '--';
  String environment = Env.environmentLabel;
  String deviceName = '--';

  LoginNotifier() {
    init();
  }

  Future<void> init() async {
    await Future.wait([
      loadAppInfo(),
       rememberMeData(),
    ]);
  }

  Future<void> _handleRememberMe() async {
    if (isChecked) {
      final rememberData = RememberMeModel(
        userName: userNameController.text,
        password: passwordController.text,
      );
      HiveStorageService.setRememberMe(jsonEncode(rememberData));
    }
  }

  void toggleRememberMe() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      environment = Env.environmentLabel;
    } catch (_) {
      appVersion = '--';
      buildNumber = '--';
      environment = Env.environmentLabel;
    }
    notifyListeners();
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    final password = value?.trim() ?? '';

    if (password.isEmpty) {
      return 'Please enter your password';
    }

    // if (password.length < 6) {
    //   return 'Password must be at least 6 characters';
    // }

    return null;
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> performLogin(BuildContext context) async {
    if (!validateAndSave()) return;

    FocusScope.of(context).unfocus();
    isLoading = true;
    notifyListeners();

    try {
      final request = LoginRequest(
        email: userNameController.text.trim(),
        password: encryptAES(passwordController.text.trim()),
      );

      final result = await CommonRepository.instance.apiLogin(request);

      if (result is LoginResponse && result.success == true && result.data != null) {
        await _handleLoginSuccess(context, result);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.bottomScreen);
      } else if (result is ErrorResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(result.message ?? 'Login failed', context: context);
      } else {
        if (!context.mounted) return;
        ToastHelper.showError('Login failed', context: context);
      }
    } catch (_) {
      if (!context.mounted) return;
      ToastHelper.showError('Something went wrong', context: context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _handleLoginSuccess(BuildContext context, LoginResponse response) async {
    await HiveStorageService.setIsLoggedIn(true);
    await HiveStorageService.setUserData(jsonEncode(response.data?.toJson() ?? {}));

    await _handleRememberMe();

    final token = response.data?.token;
    if (token != null && token.isNotEmpty) {
      await HiveStorageService.setAccessToken(token);
    }

    if (context.mounted) {
      await context.read<UserCacheNotifier>().setUser(response.data);
    }
  }

  Future<void> rememberMeData() async {
    String? data = HiveStorageService.getRememberMe();
    if (data != null) {
      RememberMeModel rememberMeModel = RememberMeModel.fromJson(jsonDecode(data));
      userNameController.text = rememberMeModel.userName;
      passwordController.text = rememberMeModel.password;
      isChecked = true;
    }
  }

  String get footerText =>
      'Version $appVersion ($buildNumber) • Environment: $environment';

  String get footerInfoText =>
      'Version $appVersion ($buildNumber)\nEnvironment: $environment\nDevice: $deviceName';

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}