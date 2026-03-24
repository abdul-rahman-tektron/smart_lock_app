import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/utils/extensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool expand;
  final bool required;
  final bool isPassword;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final int maxLines;

  final bool isDateField;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String dateFormat;
  final VoidCallback? onPicked;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    this.hintText,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.expand = true,
    this.required = false,
    this.isPassword = false,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
    this.isDateField = false,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.dateFormat = "dd/MM/yyyy",
    this.onPicked,
  });

  Future<void> _openDatePicker(BuildContext context) async {
    final now = DateTime.now();
    DateTime init = initialDate ?? _tryParse(controller.text) ?? now;

    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            onSurface: AppColors.textPrimary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      controller.text = DateFormat(dateFormat).format(picked);
      onPicked?.call();
    }
  }

  static DateTime? _tryParse(String text) {
    try {
      final parts = text.split('/');
      if (parts.length != 3) return null;
      final d = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      final y = int.parse(parts[2]);
      return DateTime(y, m, d);
    } catch (_) {
      return null;
    }
  }

  String? _defaultValidator(String? value) {
    final v = (value ?? '').trim();
    if (required && v.isEmpty) {
      return '$title is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppFonts.text14.medium.style.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (required) ...[
              4.horizontalSpace,
              Text(
                '*',
                style: AppFonts.text14.bold.style.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
        8.verticalSpace,
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly || isDateField,
          obscureText: isPassword ? obscureText : false,
          keyboardType: isDateField
              ? TextInputType.none
              : (keyboardType ?? TextInputType.text),
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.disabled,
          onTap: isDateField
              ? () => _openDatePicker(context)
              : onTap,
          onChanged: onChanged,
          style: style ??
              AppFonts.text14.regular.style.copyWith(
                color: AppColors.textPrimary,
              ),
          validator: (value) {
            final base = _defaultValidator(value);
            if (base != null) return base;
            return validator?.call(value);
          },
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter $title',
            hintStyle: AppFonts.text14.regular.style.copyWith(
              color: AppColors.textSecondary.withOpacity(0.8),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon ??
                (isDateField
                    ? const Icon(
                  Icons.calendar_month,
                  color: AppColors.textSecondary,
                )
                    : null),
            filled: true,
            fillColor: AppColors.backgroundField,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            errorStyle: AppFonts.text12.regular.style.copyWith(
              color: AppColors.error,
            ),
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
          ),
        ),
      ],
    );

    return expand ? Expanded(child: field) : field;
  }
}