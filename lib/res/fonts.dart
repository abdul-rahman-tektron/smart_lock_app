import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/utils/extensions.dart';

// AppFonts provides font sizes with weights and colors
class AppFonts {
  AppFonts._();

  static const String primaryFont = 'Lexend'; // Default font (English)

  static const String arabicFont = 'DroidKufi';


  // Common font sizes as static getters returning helper class
  static _FontSizeStyles get text2 => const _FontSizeStyles(2);
  static _FontSizeStyles get text4 => const _FontSizeStyles(4);
  static _FontSizeStyles get text5 => const _FontSizeStyles(5);
  static _FontSizeStyles get text6 => const _FontSizeStyles(6);
  static _FontSizeStyles get text8 => const _FontSizeStyles(8);
  static _FontSizeStyles get text10 => const _FontSizeStyles(10);
  static _FontSizeStyles get text11 => const _FontSizeStyles(11);
  static _FontSizeStyles get text12 => const _FontSizeStyles(12);
  static _FontSizeStyles get text14 => const _FontSizeStyles(14);
  static _FontSizeStyles get text16 => const _FontSizeStyles(16);
  static _FontSizeStyles get text17 => const _FontSizeStyles(17);
  static _FontSizeStyles get text18 => const _FontSizeStyles(18);
  static _FontSizeStyles get text20 => const _FontSizeStyles(20);
  static _FontSizeStyles get text22 => const _FontSizeStyles(22);
  static _FontSizeStyles get text24 => const _FontSizeStyles(24);
  static _FontSizeStyles get text26 => const _FontSizeStyles(26);
  static _FontSizeStyles get text28 => const _FontSizeStyles(28);
  static _FontSizeStyles get text48 => const _FontSizeStyles(48);

  // Colors
  static const Color black = AppColors.textPrimary;
  static const Color white = AppColors.white;
  static const Color grey = AppColors.textSecondary;
  static const Color red = AppColors.error;
}

class _FontSizeStyles {
  final double size;
  const _FontSizeStyles(this.size);

  double get _min => size <= 8 ? 6 : 10; // ✅ allow smaller labels

  _TextStyleBuilder get regular =>
      _TextStyleBuilder(size: FontScaler.scale(size, min: _min), weight: FontWeight.normal);

  _TextStyleBuilder get medium =>
      _TextStyleBuilder(size: FontScaler.scale(size, min: _min), weight: FontWeight.w500);

  _TextStyleBuilder get semiBold =>
      _TextStyleBuilder(size: FontScaler.scale(size, min: _min), weight: FontWeight.w600);

  _TextStyleBuilder get bold =>
      _TextStyleBuilder(size: FontScaler.scale(size, min: _min), weight: FontWeight.bold);
}

class _TextStyleBuilder {
  final double size;
  final FontWeight weight;
  final Color color;

  const _TextStyleBuilder({
    required this.size,
    required this.weight,
    this.color = AppFonts.black,
  });

  // Colors as getters returning new instances with changed color:
  _TextStyleBuilder get black => _copyWithColor(AppFonts.black);
  _TextStyleBuilder get white => _copyWithColor(AppFonts.white);
  _TextStyleBuilder get grey => _copyWithColor(AppFonts.grey);
  _TextStyleBuilder get red => _copyWithColor(AppFonts.red);
  _TextStyleBuilder get primary => _copyWithColor(AppColors.primary);

  _TextStyleBuilder _copyWithColor(Color color) {
    return _TextStyleBuilder(size: size, weight: weight, color: color);
  }

  TextStyle get style => TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: 0.5,
    // fontFamily is handled separately by FontResolver if needed
  );
}

class FontScaler {
  static double scale(double baseSize, {double min = 10, double max = 64}) {
    double scaled = baseSize.sp;

    if (ScreenUtil().screenWidth > 1200) {
      scaled *= 1.2;
    } else if (ScreenUtil().screenWidth < 400) {
      scaled *= 0.9;
    }

    return scaled.clamp(min, max);
  }
}

// FontResolver to switch fonts based on text language
class FontResolver {
  static TextStyle resolve(String text, TextStyle baseStyle) {
    final isArabic = text.isArabic();
    return baseStyle.copyWith(
      fontFamily: isArabic ? AppFonts.arabicFont : AppFonts.primaryFont,
    );
  }
}
