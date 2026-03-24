import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/res/images.dart';
import 'package:smart_lock_app/screens/otp_verification/otp_verification_notifier.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String? email;

  const OtpVerificationScreen({
    super.key,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpVerificationNotifier(email: email),
      child: Consumer<OtpVerificationNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, OtpVerificationNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "OTP Verification",
          style: AppFonts.text16.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              100.verticalSpace,
              // _topHeader(),
              // 40.verticalSpace,
              _headerCard(),
              16.verticalSpace,
              _contentCard(context, notifier),
              20.verticalSpace,
            ],
          ),
        ),
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
              Icons.verified_user_outlined,
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
                  "Verify Your Account",
                  style: AppFonts.text16.bold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Enter the 6-digit code sent to your email address",
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

  Widget _contentCard(
      BuildContext context,
      OtpVerificationNotifier notifier,
      ) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verification Code",
            style: AppFonts.text12.medium.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          8.verticalSpace,
          Text(
            notifier.email ?? "your registered email",
            style: AppFonts.text14.semiBold.style.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              notifier.otpLength,
                  (index) => _otpBox(notifier, index),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton(
              onPressed: notifier.isLoading
                  ? null
                  : () => notifier.verifyOtp(context),
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.white,
                  ),
                ),
              )
                  : Text(
                "Verify OTP",
                style: AppFonts.text14.semiBold.style.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          16.verticalSpace,
          Center(
            child: notifier.isResendEnabled
                ? TextButton(
              onPressed: notifier.resendOtp,
              child: Text(
                "Resend Code",
                style: AppFonts.text12.semiBold.style.copyWith(
                  color: AppColors.primary,
                ),
              ),
            )
                : Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundField,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                "Resend available in ${notifier.secondsRemaining}s",
                style: AppFonts.text12.medium.style.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topHeader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.tektronixLogo,
            height: 100.sp,
          ),
        ],
      ),
    );
  }

  Widget _otpBox(OtpVerificationNotifier notifier, int index) {
    return SizedBox(
      width: 46.w,
      child: Theme(
        data: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.white,
            )
        ),
        child: TextField(
          controller: notifier.otpControllers[index],
          focusNode: notifier.focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          maxLength: 1,
          showCursor: false,
          enableInteractiveSelection: false,
          onTap: () => notifier.onOtpTap(index),
          onChanged: (value) => notifier.onOtpChange(value, index),
          style: AppFonts.text18.bold.style.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: AppColors.background,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
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
                width: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}