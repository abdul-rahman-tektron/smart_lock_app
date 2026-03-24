import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/reset_password/reset_password_notifier.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? email;
  final String? otp;

  const ResetPasswordScreen({
    super.key,
    this.email,
    this.otp,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordNotifier(email: email, otp: otp),
      child: Consumer<ResetPasswordNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ResetPasswordNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Reset Password",
          style: AppFonts.text16.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Form(
            key: notifier.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerCard(),
                16.verticalSpace,
                _formCard(
                  children: [
                    _fieldTitle("Email Address"),
                    8.verticalSpace,
                    _passwordField(
                      controller: notifier.emailController,
                      hintText: "Email address",
                      icon: LucideIcons.mail,
                      readOnly: true,
                    ),
                    14.verticalSpace,
                    _fieldTitle("New Password"),
                    8.verticalSpace,
                    _passwordField(
                      controller: notifier.newPasswordController,
                      hintText: "Enter new password",
                      icon: LucideIcons.lockKeyhole,
                      obscureText: !notifier.isNewPasswordVisible,
                      validator: notifier.validatePassword,
                      suffixIcon: IconButton(
                        onPressed: notifier.toggleNewPasswordVisibility,
                        icon: Icon(
                          notifier.isNewPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    _passwordGuideCard(notifier),
                    14.verticalSpace,
                    _fieldTitle("Confirm Password"),
                    8.verticalSpace,
                    _passwordField(
                      controller: notifier.confirmPasswordController,
                      hintText: "Confirm new password",
                      icon: LucideIcons.shieldCheck,
                      obscureText: !notifier.isConfirmPasswordVisible,
                      validator: notifier.validateConfirmPassword,
                      suffixIcon: IconButton(
                        onPressed: notifier.toggleConfirmPasswordVisibility,
                        icon: Icon(
                          notifier.isConfirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                18.verticalSpace,
                _saveButton(context, notifier),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordGuideCard(ResetPasswordNotifier notifier) {
    final password = notifier.newPasswordController.text;

    final hasMinLength = password.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]').hasMatch(password);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.shieldCheck,
                size: 16.sp,
                color: AppColors.primary,
              ),
              6.horizontalSpace,
              Expanded(
                child: Text(
                  "Password requirements",
                  style: AppFonts.text12.semiBold.style.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              Text(
                notifier.passwordStrengthText,
                style: AppFonts.text11.semiBold.style.copyWith(
                  color: notifier.passwordStrengthColor,
                ),
              ),
            ],
          ),
          10.verticalSpace,

          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: notifier.passwordStrength,
              minHeight: 6.h,
              backgroundColor: AppColors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                notifier.passwordStrengthColor,
              ),
            ),
          ),

          12.verticalSpace,

          _ruleItem("Minimum 8 characters", hasMinLength),
          _ruleItem("1 uppercase letter", hasUppercase),
          _ruleItem("1 number", hasNumber),
          _ruleItem("1 symbol", hasSymbol),
        ],
      ),
    );
  }

  Widget _ruleItem(String text, bool isValid) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(
            isValid ? LucideIcons.circleCheckBig : LucideIcons.circle,
            size: 14.sp,
            color: isValid ? AppColors.success : AppColors.textSecondary,
          ),
          8.horizontalSpace,
          Text(
            text,
            style: AppFonts.text11.medium.style.copyWith(
              color: isValid ? AppColors.success : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              LucideIcons.keyRound,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  style: AppFonts.text16.bold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Set a new password to complete your account recovery",
                  style: AppFonts.text12.medium.style.copyWith(
                    color: AppColors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.08),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _fieldTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppFonts.text12.medium.style.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool readOnly = false,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      validator: validator,
      style: AppFonts.text14.medium.style.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.text12.regular.style.copyWith(
          color: AppColors.textSecondary.withOpacity(0.75),
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: 18.sp,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: readOnly ? AppColors.backgroundField : AppColors.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.3),
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
      ),
    );
  }

  Widget _strengthIndicator(ResetPasswordNotifier notifier) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundField,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password Strength: ${notifier.passwordStrengthText}",
            style: AppFonts.text11.semiBold.style.copyWith(
              color: notifier.passwordStrengthColor,
            ),
          ),
          8.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: notifier.passwordStrength,
              minHeight: 6.h,
              backgroundColor: AppColors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                notifier.passwordStrengthColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context, ResetPasswordNotifier notifier) {
    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: ElevatedButton(
        onPressed: notifier.isLoading
            ? null
            : () => notifier.savePassword(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: notifier.isLoading
            ? SizedBox(
          height: 18.h,
          width: 18.h,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        )
            : Text(
          "Save Password",
          style: AppFonts.text14.semiBold.style.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}