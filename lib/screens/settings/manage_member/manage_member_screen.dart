import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/settings/manage_member/manage_member_notifier.dart';

class ManageMembersScreen extends StatelessWidget {
  const ManageMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManageMembersNotifier(),
      child: Consumer<ManageMembersNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ManageMembersNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Manage Members",
          style: AppFonts.text16.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: notifier.members.isEmpty
            ? Center(
          child: Text(
            "No members added yet",
            style: AppFonts.text14.medium.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        )
            : ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          itemCount: notifier.members.length,
          separatorBuilder: (_, __) => 12.verticalSpace,
          itemBuilder: (context, index) {
            final item = notifier.members[index];
            final bool isActive = item["isActive"] as bool;

            return Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: isActive
                      ? AppColors.primary.withOpacity(0.10)
                      : AppColors.textSecondary.withOpacity(0.10),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryLight
                              : AppColors.backgroundField,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          LucideIcons.userRound,
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 20.sp,
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              style: AppFonts.text14.semiBold.style.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              item["mobile"],
                              style: AppFonts.text11.medium.style.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryLight
                              : AppColors.backgroundField,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          isActive ? "Active" : "Inactive",
                          style: AppFonts.text10.bold.style.copyWith(
                            color: isActive
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: _miniTag(item["relationship"]),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: _miniTag(item["accessType"]),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: _actionButton(
                          text: isActive ? "Disable" : "Enable",
                          color: AppColors.primary,
                          onTap: () => notifier.toggleMemberStatus(index),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: _actionButton(
                          text: "Remove",
                          color: AppColors.error,
                          onTap: () => notifier.removeMember(index),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _miniTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundField,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppFonts.text11.medium.style.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppFonts.text12.semiBold.style.copyWith(
            color: color,
          ),
        ),
      ),
    );
  }
}