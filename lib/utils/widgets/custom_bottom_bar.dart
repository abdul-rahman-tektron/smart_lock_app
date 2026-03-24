import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/res/images.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = <_NavItem>[
    _NavItem("Home", LucideIcons.house),
    _NavItem("Settings", LucideIcons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.primary.withOpacity(0.10),
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: _buildItem(0)),
                SizedBox(width: 80.w),
                Expanded(child: _buildItem(1)),
              ],
            ),
          ),

          Positioned(
            top: -18.h,
            child: IgnorePointer(
              child: Container(
                width: 58.w,
                height: 58.w,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  /// Gradient gives curved surface feeling
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryAccent,
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),

                  /// Multi shadow = depth
                  boxShadow: [
                    /// Main shadow
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),

                    /// Soft outer glow
                    BoxShadow(
                      color: AppColors.primaryAccent.withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                    ),

                    /// Inner highlight simulation
                    const BoxShadow(
                      color: Colors.white24,
                      blurRadius: 2,
                      offset: Offset(-2, -2),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.aldarLogo,
                    height: 35.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    final item = _items[index];
    final selected = index == currentIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: selected
              ? Border.all(
            color: AppColors.primary.withOpacity(0.10),
          )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 20.sp,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
            8.horizontalSpace,
            Text(
              item.label,
              style: selected
                  ? AppFonts.text14.bold.style.copyWith(
                color: AppColors.primary,
              )
                  : AppFonts.text12.medium.style.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;

  const _NavItem(this.label, this.icon);
}