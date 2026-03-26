import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/core/notifier/user_cache_notifier.dart';
import 'package:smart_lock_app/res/api_constants.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/settings/settings_notifier.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsNotifier(context),
      child: Consumer<SettingsNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingsNotifier notifier) {
    final userCache = context.watch<UserCacheNotifier>();
    final user = userCache.user;

    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileCard(context, user, userCache.imageRefreshToken),
              14.verticalSpace,
              _sectionCard(
                title: "Account",
                children: [
                  _settingsTile(
                    icon: LucideIcons.userRound,
                    title: "Edit Profile",
                    subtitle: "Update your name and personal details",
                    onTap: () async {
                      final updated = await Navigator.pushNamed(context, AppRoutes.editProfile);
                      if (updated == true && context.mounted) {
                        context.read<UserCacheNotifier>().loadUser();
                      }
                    },
                  ),
                  _divider(),
                  _settingsTile(
                    icon: LucideIcons.lockKeyhole,
                    title: "Change Password",
                    subtitle: "Update your account password securely",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.changePassword);
                    },
                  ),
                ],
              ),
              14.verticalSpace,
              _sectionCard(
                title: "Access & Members",
                children: [
                  _settingsTile(
                    icon: LucideIcons.userPlus,
                    title: "Add Member",
                    subtitle: "Grant access to a family member",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.addMember);
                    },
                  ),
                  _divider(),
                  _settingsTile(
                    icon: LucideIcons.users,
                    title: "Manage Members",
                    subtitle: "View and control member access",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.manageMember);
                    },
                  ),
                  _divider(),
                  _settingsTile(
                    icon: LucideIcons.housePlus,
                    title: "Request Flat Change",
                    subtitle: "Submit a request to update your flat details",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.requestFlatChange);
                    },
                  ),
                ],
              ),
              14.verticalSpace,
              _sectionCard(
                title: "Preferences",
                children: [
                  _switchTile(
                    icon: LucideIcons.bell,
                    title: "Notifications",
                    subtitle: "Receive delivery and access alerts",
                    value: notifier.pushNotifications,
                    onChanged: notifier.togglePushNotifications,
                  ),
                  _divider(),
                  _switchTile(
                    icon: LucideIcons.fingerprintPattern,
                    title: "Biometric Login",
                    subtitle: "Use fingerprint or face ID to sign in",
                    value: notifier.biometricLogin,
                    onChanged: notifier.toggleBiometricLogin,
                  ),
                ],
              ),
              14.verticalSpace,
              _sectionCard(
                title: "Support",
                children: [
                  _settingsTile(
                    icon: LucideIcons.badgeQuestionMark,
                    title: "Help & Support",
                    subtitle: "Get assistance for your account",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.helpSupport);
                    },
                  ),
                  _divider(),
                  _settingsTile(
                    icon: LucideIcons.triangleAlert,
                    title: "Report Issue",
                    subtitle: "Report locker or delivery issues",
                    onTap: () {},
                  ),
                  _divider(),
                  _settingsTile(
                    icon: LucideIcons.fileText,
                    title: "Terms & Privacy",
                    subtitle: "Read app policies and terms",
                    onTap: () {},
                  ),
                ],
              ),
              14.verticalSpace,
              _logoutButton(context, notifier),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileCard(BuildContext context, UserData? user, int imageRefreshToken) {
    final userCache = context.watch<UserCacheNotifier>();
    final user = userCache.user;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
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
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.white.withOpacity(0.12),
            ),
            clipBehavior: Clip.antiAlias,
            child: (user?.profileImage?.isNotEmpty ?? false)
                ? Image.network(
              "${ApiConstants.apiImageUrl}${user!.profileImage!}?t=${userCache.imageRefreshToken}",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                LucideIcons.userRound,
                color: AppColors.primary,
                size: 24.sp,
              ),
            )
                : Icon(LucideIcons.userRound, color: AppColors.white, size: 24.sp),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.fullName ?? "",
                  style: AppFonts.text16.bold.style.copyWith(color: AppColors.white),
                ),
                4.verticalSpace,
                Text(
                  "No.${user?.flatNo}, ${user?.floorNo} Floor, ${user?.buildingName}",
                  style: AppFonts.text12.medium.style.copyWith(
                    color: AppColors.white.withOpacity(0.85),
                  ),
                ),
                4.verticalSpace,
                Text(
                  user?.phoneNumber ?? "",
                  style: AppFonts.text12.regular.style.copyWith(
                    color: AppColors.white.withOpacity(0.82),
                  ),
                ),
                2.verticalSpace,
                Text(
                  user?.email ?? "",
                  style: AppFonts.text12.regular.style.copyWith(
                    color: AppColors.white.withOpacity(0.82),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.08)),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowColor, blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Text(
              title,
              style: AppFonts.text12.bold.style.copyWith(color: AppColors.textPrimary),
            ),
          ),
          6.verticalSpace,
          ...children,
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: AppColors.primary, size: 18.sp),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.text12.semiBold.style.copyWith(color: AppColors.textPrimary),
                  ),
                  3.verticalSpace,
                  Text(
                    subtitle,
                    style: AppFonts.text10.regular.style.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18.sp),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.text12.semiBold.style.copyWith(color: AppColors.textPrimary),
                ),
                3.verticalSpace,
                Text(
                  subtitle,
                  style: AppFonts.text10.regular.style.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.90,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.white,
              activeTrackColor: AppColors.primary,
              inactiveThumbColor: AppColors.white,
              inactiveTrackColor: AppColors.textSecondary.withOpacity(0.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: AppColors.primary.withOpacity(0.08));
  }

  Widget _logoutButton(BuildContext context, SettingsNotifier notifier) {
    return GestureDetector(
      onTap: () => notifier.logoutFunctionality(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.error.withOpacity(0.14)),
          boxShadow: const [
            BoxShadow(color: AppColors.shadowColor, blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.logOut, color: AppColors.error, size: 18.sp),
            8.horizontalSpace,
            Text("Logout", style: AppFonts.text14.semiBold.style.copyWith(color: AppColors.error)),
          ],
        ),
      ),
    );
  }
}
