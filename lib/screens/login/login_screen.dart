import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/res/images.dart';
import 'package:smart_lock_app/utils/enums.dart';
import 'package:smart_lock_app/utils/widgets/custom_buttons.dart';
import 'package:smart_lock_app/utils/widgets/custom_popup.dart';
import 'package:smart_lock_app/utils/widgets/custom_textfield.dart';

import 'login_notifier.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(),
      child: Consumer<LoginNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, LoginNotifier n) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: n.formKey,
                      child: Column(
                        children: [
                          40.verticalSpace,
                          _topHeader(),
                          40.verticalSpace,
                          _card(
                            child: _cardContent(context, n),
                          ),
                          18.verticalSpace,
                          _footer(context, n),
                          10.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _topHeader() {
    return Column(
      children: [
        Image.asset(
          AppImages.tektronixLogo,
          height: 100.sp,
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.10),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _cardContent(BuildContext context, LoginNotifier n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Sign In",
            style: AppFonts.text22.bold.style.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        8.verticalSpace,
        Center(
          child: Text(
            "Access your locker deliveries and settings",
            style: AppFonts.text14.regular.style.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        15.verticalSpace,
        _emailField(n),

        16.verticalSpace,
        _passwordField(n),

        12.verticalSpace,
        _rememberRow(context, n),

        22.verticalSpace,
        _primarySignIn(context, n),
        // 10.verticalSpace,
        // Row(
        //   children: [
        //     15.horizontalSpace,
        //     Expanded(child: Divider()),
        //     10.horizontalSpace,
        //     Text("OR"),
        //     10.horizontalSpace,
        //     Expanded(child: Divider()),
        //     15.horizontalSpace
        //   ],
        // ),
        // 10.verticalSpace,
        // _uaePassButton(context, n),

        18.verticalSpace,
        Center(child: _forgotPassword(context)),

        20.verticalSpace,
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Powered by ",
                  style: AppFonts.text12.medium.style.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                TextSpan(
                  text: "Tektronix Technologies",
                  style: AppFonts.text12.bold.primary.style,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _fieldTitle(String title) {
    return Text(
      title,
      style: AppFonts.text14.medium.style.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _emailField(LoginNotifier n) {
    return CustomTextField(
      controller: n.userNameController,
      title: "Email",
      hintText: "Enter your email",
      expand: false,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(
        Icons.mail_outline,
        color: AppColors.primary,
      ),
      validator: n.validateEmail,
    );
  }

  Widget _passwordField(LoginNotifier n) {
    return CustomTextField(
      controller: n.passwordController,
      title: "Password",
      hintText: "Enter your password",
      expand: false,
      isPassword: true,
      obscureText: !n.isPasswordVisible,
      prefixIcon: const Icon(
        Icons.lock_outline,
        color: AppColors.primary,
      ),
      suffixIcon: IconButton(
        onPressed: n.togglePasswordVisibility,
        icon: Icon(
          n.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
      ),
      validator: n.validatePassword,
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppFonts.text14.regular.style.copyWith(
        color: AppColors.textSecondary.withOpacity(0.8),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.backgroundField,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: AppColors.primary.withOpacity(0.08),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.2,
        ),
      ),
    );
  }

  Widget _rememberRow(BuildContext context, LoginNotifier n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _rememberMeWidget(n),
      ],
    );
  }

  Widget _rememberMeWidget(LoginNotifier n) {
    return GestureDetector(
      onTap: n.toggleRememberMe,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: n.isChecked ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: n.isChecked
                    ? AppColors.primary
                    : AppColors.textSecondary.withOpacity(0.4),
              ),
            ),
            child: n.isChecked
                ? Icon(
              Icons.check,
              size: 14.sp,
              color: AppColors.white,
            )
                : null,
          ),
          10.horizontalSpace,
          Text(
            "Remember me",
            style: AppFonts.text14.regular.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showForgotPasswordPopup(context);
      },
      child: Text(
        "Forgot password?",
        style: AppFonts.text14.medium.style.copyWith(
          color: AppColors.primary,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _primarySignIn(BuildContext context, LoginNotifier n) {
    return CustomButton(
      text: "Sign In",
      type: CustomButtonType.primary,
      isLoading: n.isLoading,
      onPressed: () => n.performLogin(context),
    );
  }

  Widget _uaePassButton(BuildContext context, LoginNotifier n) {
    return CustomButton(
      text: "UAE Pass",
      type: CustomButtonType.outline,
      onPressed: () {},
      image: AppImages.uaePass,
      imageOnLeft: true,
      imageSize: 32,
      foregroundColor: AppColors.textPrimary,
    );
  }

  Widget _footer(BuildContext context, LoginNotifier n) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Version ",
            style: AppFonts.text12.bold.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          TextSpan(
            text: n.appVersion,
            style: AppFonts.text12.regular.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          TextSpan(
            text: "  •  Env: ",
            style: AppFonts.text12.bold.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          TextSpan(
            text: n.environment,
            style: AppFonts.text12.regular.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}