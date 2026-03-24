import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/core/notifier/user_cache_notifier.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/res/images.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/screen_size.dart';
import 'package:smart_lock_app/utils/utility/hive_storage.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int)? onItemSelected;
  final int? selectedIndex;

  const CustomDrawer({
    super.key,
    this.onItemSelected,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCacheNotifier>().user;

    return SafeArea(
      child: Drawer(
        width: ScreenSize.width * 0.82,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildUserDetails(user),
            12.verticalSpace,
            Expanded(child: _buildMenuList(context)),
            _buildLogoutButton(context),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }

  UserData? _getSavedUser() {
    try {
      final userJson = HiveStorageService.getUserData();

      if (userJson == null || userJson.isEmpty) return null;

      final Map<String, dynamic> map = jsonDecode(userJson);
      return UserData.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.10),
          ),
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            AppImages.tektronixLogo,
            height: 60.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails(UserData? user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.08),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(
              LucideIcons.user,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (user?.fullName?.trim().isNotEmpty ?? false)
                      ? user!.fullName!
                      : "Guest User",
                  style: AppFonts.text16.bold.style.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpace,
                Text(
                  (user?.email?.trim().isNotEmpty ?? false)
                      ? user!.email!
                      : "No Email",
                  style: AppFonts.text12.regular.style.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final items = [
      _DrawerItemData(LucideIcons.house, "Home", 0),
      _DrawerItemData(LucideIcons.package, "Package History", 1),
      _DrawerItemData(LucideIcons.settings, "Settings", 2),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: items.length,
      separatorBuilder: (_, __) => 4.verticalSpace,
      itemBuilder: (_, index) {
        final item = items[index];
        return _buildDrawerItem(
          context,
          item.icon,
          item.title,
          item.value,
          selected: selectedIndex == item.value,
        );
      },
    );
  }

  Widget _buildDrawerItem(
      BuildContext context,
      IconData icon,
      String title,
      int value, {
        bool selected = false,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () => _handleNavigation(context, value),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryLight : AppColors.transparent,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withOpacity(0.18)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.white
                      : AppColors.backgroundField,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: selected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Text(
                  title,
                  style: (selected
                      ? AppFonts.text14.bold
                      : AppFonts.text14.medium)
                      .style
                      .copyWith(
                    color: selected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              // Icon(
              //   Icons.chevron_right_rounded,
              //   color: AppColors.textSecondary,
              //   size: 20.sp,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: 200.w,
        height: 42.h,
        child: ElevatedButton(
          onPressed: () => logoutFunctionality(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
              side: BorderSide(
                color: AppColors.error.withOpacity(0.22),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.logOut,
                size: 18.sp,
                color: AppColors.error,
              ),
              10.horizontalSpace,
              Text(
                "Logout",
                style: AppFonts.text14.semiBold.style.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int value) {
    Navigator.pop(context);
    onItemSelected?.call(value);

    switch (value) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.bottomScreen, arguments: {"currentIndex" : 0});
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.packageHistory);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.bottomScreen, arguments: {"currentIndex" : 1});
        break;
    }
  }

  Future<void> logoutFunctionality(BuildContext context) async {
    await HiveStorageService.clearOnLogout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
          (route) => false,
    );
  }
}

class _DrawerItemData {
  final IconData icon;
  final String title;
  final int value;

  const _DrawerItemData(this.icon, this.title, this.value);
}