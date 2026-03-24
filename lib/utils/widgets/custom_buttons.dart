import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/utils/enums.dart';
import 'package:smart_lock_app/utils/widgets/loader.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  final IconData? icon;
  final Widget? widget;
  final Color? iconColor;
  final double? iconSize;
  final bool iconOnLeft;

  final String? image;
  final double? imageSize;
  final bool imageOnLeft;

  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;

  final CustomButtonType type;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;
  final Widget? loader;

  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.textStyle,
    this.icon,
    this.widget,
    this.iconColor,
    this.iconSize,
    this.iconOnLeft = false,
    this.image,
    this.imageSize,
    this.imageOnLeft = false,
    this.isLoading = false,
    this.fullWidth = true,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.type = CustomButtonType.primary,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
    this.loader,
  });

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = _resolveBackgroundColor();
    final Color textColor = _resolveForegroundColor();
    final Color strokeColor = _resolveBorderColor();

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height ?? 45.h,
      child: ElevatedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          disabledBackgroundColor: bgColor.withOpacity(0.65),
          disabledForegroundColor: textColor.withOpacity(0.7),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 14.r),
            side: BorderSide(
              color: strokeColor,
              width: type == CustomButtonType.outline ? 1 : 0.8,
            ),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          alignment: Alignment.center,
          child: isLoading
              ? (loader ??
              DotCircleSpinner(
                size: 22.h,
                dotSize: 2       .h,
              ))
              : _buildContent(textColor),
        ),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null && iconOnLeft) ...[
          Icon(
            icon,
            size: iconSize ?? 18.sp,
            color: iconColor ?? textColor,
          ),
          8.horizontalSpace,
        ],

        if (image != null && imageOnLeft) ...[
          Image.asset(
            image!,
            height: imageSize ?? 22.h,
            width: imageSize ?? 22.w,
            fit: BoxFit.contain,
          ),
          8.horizontalSpace,
        ],

        if (widget != null) ...[
          widget!,
        ] else ...[
          Flexible(
            child: Text(
              text ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textStyle ??
                  AppFonts.text16.semiBold.style.copyWith(
                    color: textColor,
                  ),
            ),
          ),
        ],

        if (icon != null && !iconOnLeft) ...[
          8.horizontalSpace,
          Icon(
            icon,
            size: iconSize ?? 18.sp,
            color: iconColor ?? textColor,
          ),
        ],

        if (image != null && !imageOnLeft) ...[
          8.horizontalSpace,
          Image.asset(
            image!,
            height: imageSize ?? 22.h,
            width: imageSize ?? 22.w,
            fit: BoxFit.contain,
          ),
        ],
      ],
    );
  }

  Color _resolveBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;

    switch (type) {
      case CustomButtonType.primary:
        return AppColors.primary;
      case CustomButtonType.outline:
        return AppColors.white;
      case CustomButtonType.plain:
        return AppColors.transparent;
    }
  }

  Color _resolveForegroundColor() {
    if (foregroundColor != null) return foregroundColor!;

    switch (type) {
      case CustomButtonType.primary:
        return AppColors.textOnPrimary;
      case CustomButtonType.outline:
        return AppColors.textPrimary;
      case CustomButtonType.plain:
        return AppColors.primary;
    }
  }

  Color _resolveBorderColor() {
    if (borderColor != null) return borderColor!;

    switch (type) {
      case CustomButtonType.primary:
        return AppColors.primary;
      case CustomButtonType.outline:
        return AppColors.textSecondary.withOpacity(0.35);
      case CustomButtonType.plain:
        return Colors.transparent;
    }
  }
}

class CustomButtonBig extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final IconData? icon;
  final String? image;
  final double? imageSize;
  final double? iconSize;
  final Color? iconColor;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;
  final CustomButtonType type;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;

  const CustomButtonBig({
    super.key,
    this.text,
    this.onPressed,
    this.textStyle,
    this.icon,
    this.image,
    this.imageSize,
    this.iconSize,
    this.iconColor,
    this.isLoading = false,
    this.fullWidth = true,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.type = CustomButtonType.primary,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ??
        (type == CustomButtonType.primary
            ? AppColors.primary
            : AppColors.white);

    final Color textColor = foregroundColor ??
        (type == CustomButtonType.primary
            ? AppColors.textOnPrimary
            : AppColors.textPrimary);

    final Color strokeColor = borderColor ??
        (type == CustomButtonType.outline
            ? AppColors.textSecondary.withOpacity(0.35)
            : AppColors.primary);

    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 18.r),
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: fullWidth ? double.infinity : width,
        height: height ?? 110.h,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius ?? 18.r),
          border: Border.all(
            color: strokeColor,
            width: type == CustomButtonType.outline ? 1 : 0.8,
          ),
          boxShadow: type == CustomButtonType.primary
              ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ]
              : [],
        ),
        child: Center(
          child: isLoading
              ? DotCircleSpinner(
            size: 26.h,
            dotSize: 3.h,
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: iconSize ?? 34.sp,
                  color: iconColor ?? textColor,
                ),
                10.verticalSpace,
              ],
              if (image != null) ...[
                Image.asset(
                  image!,
                  height: imageSize ?? 28.h,
                  width: imageSize ?? 28.w,
                  fit: BoxFit.contain,
                ),
                10.verticalSpace,
              ],
              Text(
                text ?? "",
                textAlign: TextAlign.center,
                style: textStyle ??
                    AppFonts.text14.semiBold.style.copyWith(
                      color: textColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}