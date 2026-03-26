import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';

class AppThemes {
  AppThemes._();

  /// Builds theme data based on language code
  static ThemeData lightTheme({required String languageCode}) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: languageCode == 'ar' ? AppFonts.arabicFont : AppFonts.primaryFont,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light, // Android
          statusBarBrightness: Brightness.light,      // iOS (dark text → black, set to .dark for proper contrast)
        ),
        color: AppColors.background,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.textPrimary,
        selectionColor: AppColors.primary.withOpacity(0.4),
        selectionHandleColor: AppColors.textPrimary,
      ),
      useMaterial3: true,
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        headerBackgroundColor: AppColors.primary,
        headerForegroundColor: AppColors.white,
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.textPrimary;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
        todayForegroundColor: const WidgetStatePropertyAll(AppColors.primary),
        todayBorder: const BorderSide(color: AppColors.primary),
        yearForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.textPrimary;
        }),
        yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        cancelButtonStyle: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          textStyle: AppFonts.text14.medium.style,
        ),
        confirmButtonStyle: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppFonts.text14.semiBold.style,
        ),
      ),
      // Extend with more theme customizations if needed
    );
  }
}
