import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/utils/extensions.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/res/colors.dart';

Future<void> showErrorPopup(
    BuildContext context,
    String message, {
      String? title,
      String? primaryText,
      String? secondaryText,
      IconData? titleIcons,
      Color? titleIconColor,
      VoidCallback? onPrimary,
      VoidCallback? onSecondary,
      bool? homeNavigation = true,
      bool barrierDismissible = false,
    }) async {
  Future<void> defaultPrimary() async {
    // String title = S.of(context).actionRequired;
    // String primaryText = S.of(context).ok;
    Navigator.of(context).pop();
    if (homeNavigation ?? true) {
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //   AppRoutes.welcome,
      //       (route) => false,
      // );
    }
  }

  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Branded dialog',
    barrierColor: Colors.black.withOpacity(0.35),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, __) {
      final curved = CurvedAnimation(
        parent: anim,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 260.w, // slightly narrower dialog
                maxHeight: 0.6.sh, // smaller height
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Material(
                  color: Colors.transparent,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor.withOpacity(0.3),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: AppColors.backgroundField),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.secondary,
                                  AppColors.secondaryLight,
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  titleIcons ?? Icons.error_outline,

                                  color: titleIconColor ?? AppColors.white,
                                  size: 16.w,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    title ?? context.locale.actionRequired,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Message body
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8.sp,
                                height: 1.35,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),

                          // Divider(
                          //   color: AppColors.backgroundField.withOpacity(0.5),
                          //   height: 12.h,
                          //   thickness: 1,
                          // ),

                          // Buttons
                          Padding(
                            padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  child: FilledButton(
                                    onPressed: () async {
                                      if (onPrimary != null) {
                                        Navigator.of(context).pop();
                                        onPrimary();
                                      } else {
                                        await defaultPrimary();
                                      }
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.secondary,
                                      foregroundColor: AppColors.white,
                                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      primaryText ?? context.locale.ok,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                if (secondaryText != null) ...[
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        onSecondary?.call();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(vertical: 3.h),
                                        side: const BorderSide(color: AppColors.secondary),
                                        foregroundColor: AppColors.secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: Text(
                                        secondaryText,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}