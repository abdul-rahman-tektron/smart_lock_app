import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/res/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawer;
  final bool showBackButton;
  final VoidCallback? onTapNotification;
  final String? title;
  final bool showLogo;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.showDrawer = false,
    this.showBackButton = true,
    this.onTapNotification,
    this.title,
    this.showLogo = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          height: 1.h,
          color: AppColors.primary.withOpacity(0.10),
        ),
      ),
      leadingWidth: 60.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 14.w),
        child: showDrawer
            ? _drawerButton(context)
            : (showBackButton ? _backButton(context) : const SizedBox()),
      ),
      title: _buildTitle(),
      actions: actions ??
          [
            if (onTapNotification != null)
              Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: _iconButton(
                  icon: LucideIcons.bell,
                  onTap: onTapNotification,
                ),
              ),
          ],
    );
  }

  Widget _buildTitle() {
    if (title != null && title!.trim().isNotEmpty) {
      return Text(
        title!,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        textAlign: TextAlign.center,
      );
    }

    if (showLogo) {
      return Text("Smart Locker System", style: AppFonts.text14.bold.style.copyWith(
        color: AppColors.primary
      ),);
      // return Opacity(
      //   opacity: 0.95,
      //   child: Image.asset(
      //     AppImages.tektronixLogo,
      //     height: 34.h,
      //     fit: BoxFit.contain,
      //   ),
      // );
    }

    return const SizedBox.shrink();
  }

  Widget _drawerButton(BuildContext context) {
    return Builder(
      builder: (ctx) => _iconButton(
        icon: LucideIcons.logs,
        onTap: () => Scaffold.of(ctx).openDrawer(),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return _iconButton(
      icon: LucideIcons.arrowLeft,
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _iconButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          width: 40.w,
          height: 40.w,
          margin: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.backgroundField,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.10),
            ),
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}