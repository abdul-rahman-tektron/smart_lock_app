import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/utils/regex.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/widgets/custom_textfield.dart';

void showForgotPasswordPopup(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.textPrimary.withOpacity(0.5),
    builder: (popupContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 18.w),
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (_, loading, __) {
            return Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primaryDark,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Icon(
                            LucideIcons.mailSearch,
                            color: AppColors.white,
                            size: 22.sp,
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Forgot Password",
                                style: AppFonts.text16.bold.style.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                "Reset your password using email verification",
                                style: AppFonts.text12.medium.style.copyWith(
                                  color: AppColors.white.withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () => Navigator.pop(popupContext),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.close,
                              color: AppColors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  25.verticalSpace,

                  /// Body
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Email Address",
                      //   style: AppFonts.text12.medium.style.copyWith(
                      //     color: AppColors.textSecondary,
                      //   ),
                      // ),
                      // 8.verticalSpace,
                      CustomTextField(
                        controller: emailController,
                        title: "Email Address",
                        prefixIcon: Icon(
                          LucideIcons.mail,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        expand: false,
                      ),
                      // TextFormField(
                      //   controller: emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   style: AppFonts.text14.medium.style.copyWith(
                      //     color: AppColors.textPrimary,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "Enter your email address",
                      //     hintStyle: AppFonts.text12.regular.style.copyWith(
                      //       color: AppColors.textSecondary.withOpacity(0.75),
                      //     ),
                      //     prefixIcon: Icon(
                      //       LucideIcons.mail,
                      //       color: AppColors.primary,
                      //       size: 18.sp,
                      //     ),
                      //     filled: true,
                      //     fillColor: AppColors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 14.w,
                      //       vertical: 14.h,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(14.r),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(14.r),
                      //       borderSide: BorderSide(
                      //         color: AppColors.primary.withOpacity(0.08),
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(14.r),
                      //       borderSide: const BorderSide(
                      //         color: AppColors.primary,
                      //         width: 1.2,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      12.verticalSpace,
                      Text(
                        "We’ll send a 6-digit OTP to this email so you can reset your password.",
                        style: AppFonts.text11.regular.style.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  25.verticalSpace,

                  /// Actions
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46.h,
                          child: OutlinedButton(
                            onPressed: loading
                                ? null
                                : () => Navigator.pop(popupContext),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.primary.withOpacity(0.18),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: AppFonts.text12.semiBold.style.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: SizedBox(
                          height: 46.h,
                          child: ElevatedButton(
                            onPressed: loading
                                ? null
                                : () async {
                              final email = emailController.text.trim();
                              //
                              // if (email.isEmpty) {
                              //   ToastHelper.showError("Email is required");
                              //   return;
                              // }
                              //
                              // if (!RegExp(
                              //   RegexPatterns.email,
                              // ).hasMatch(email)) {
                              //   ToastHelper.showError(
                              //     "Please enter a valid email",
                              //   );
                              //   return;
                              // }
                              //
                              // isLoading.value = true;
                              //
                              // final response = await CommonRepository
                              //     .instance
                              //     .apiForgetPassword(
                              //   SendOtpRequest(email: email),
                              // );
                              //
                              // isLoading.value = false;
                              //
                              // if (response == "OTP sent to your email.") {
                                Navigator.pop(popupContext);
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.otpVerification,
                                  arguments: email,
                                );
                              // } else if (response is ErrorResponse) {
                              //   ToastHelper.showError("Invalid email");
                              // } else {
                              //   ToastHelper.showError(
                              //     "Failed to send OTP",
                              //   );
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: loading
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
                              "Send OTP",
                              style:
                              AppFonts.text12.semiBold.style.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}