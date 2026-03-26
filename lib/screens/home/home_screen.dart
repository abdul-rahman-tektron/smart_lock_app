import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/model/package/package_list_response.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/home/home_notifier.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(),
      child: Consumer<HomeNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeNotifier notifier) {
    return DefaultTabController(
      length: notifier.tabs,
      child: Scaffold(
        backgroundColor: AppColors.backgroundSoft,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 140.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _welcomeSection(notifier),
                    12.verticalSpace,
                    _summarySection(notifier),
                    16.verticalSpace,
                    Expanded(
                      child: _tabSection(notifier),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeSection(HomeNotifier notifier) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning",
                  style: AppFonts.text12.medium.style.copyWith(
                    color: AppColors.white.withOpacity(0.88),
                  ),
                ),
                4.verticalSpace,
                Text(
                  notifier.userName,
                  style: AppFonts.text18.bold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  notifier.unitName,
                  style: AppFonts.text12.regular.style.copyWith(
                    color: AppColors.white.withOpacity(0.82),
                  ),
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Icon(
              LucideIcons.handshake,
              color: AppColors.white,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summarySection(HomeNotifier notifier) {
    if (notifier.isLoading) {
      return Row(
        children: [
          Expanded(child: _loadingSummaryCard()),
          8.horizontalSpace,
          Expanded(child: _loadingSummaryCard()),
          8.horizontalSpace,
          Expanded(child: _loadingSummaryCard()),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            title: "Active Package",
            count: notifier.activeCount.toString(),
            icon: LucideIcons.package,
            color: AppColors.primary,
            bgColor: AppColors.primary.withOpacity(0.08),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _summaryCard(
            title: "Overdue Package",
            count: notifier.overdueCount.toString(),
            icon: LucideIcons.triangleAlert,
            color: AppColors.warning,
            bgColor: AppColors.warning.withOpacity(0.10),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _summaryCard(
            title: "Used Package",
            count: notifier.usedCount.toString(),
            icon: LucideIcons.circleCheckBig,
            color: AppColors.textSecondary,
            bgColor: AppColors.textSecondary.withOpacity(0.12),
          ),
        ),
      ],
    );
  }

  Widget _loadingSummaryCard() {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: DotCircleSpinner(size: 30, color: AppColors.primary, dotSize: 2.5,),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: color.withOpacity(0.12),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Icon(
              icon,
              color: color.withOpacity(0.05),
              size: 60.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      count,
                      style: AppFonts.text20.bold.style.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppFonts.text12.medium.style.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabSection(HomeNotifier notifier) {
    return Column(
      children: [
        Container(
          height: 42.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.15),
            ),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.textSecondary,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppFonts.text12.bold.style,
            unselectedLabelStyle: AppFonts.text12.medium.style,
            tabs: [
              Tab(text: notifier.activeTabLabel),
              Tab(text: notifier.usedTabLabel),
            ],
          ),
        ),
        10.verticalSpace,
        Expanded(
          child: TabBarView(
            children: [
              _deliveryList(
                deliveries: notifier.activeDeliveries,
                isEmptyText: "No active or overdue package",
                notifier: notifier,
              ),
              _deliveryList(
                deliveries: notifier.usedInactiveDeliveries,
                isEmptyText: "No used or expired package",
                notifier: notifier,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _deliveryList({
    required List<PackageListDataItem> deliveries,
    required String isEmptyText,
    required HomeNotifier notifier,
  }) {
    if (notifier.isLoading) {
      return const Center(
        child: DotCircleSpinner(size: 60, color: AppColors.primary, dotSize: 5,),
      );
    }

    if (deliveries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.packageOpen,
              size: 30.sp,
              color: AppColors.textSecondary,
            ),
            10.verticalSpace,
            Text(
              isEmptyText,
              style: AppFonts.text14.medium.style.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: deliveries.length,
      padding: EdgeInsets.zero,
      
      separatorBuilder: (_, __) => 8.verticalSpace,
      itemBuilder: (context, index) {
        final item = deliveries[index];
        return _deliveryCard(context, notifier, item);
      },
    );
  }

  Widget _deliveryCard(
      BuildContext context,
      HomeNotifier notifier,
      PackageListDataItem item,
      ) {
    final String status = notifier.getStatusLabel(item);
    final String statusKey = status.toLowerCase();

    final bool isOverdue = statusKey == "overdue";
    final bool isUsed = statusKey == "used";
    final bool isExpired = statusKey == "expired";

    final Color accentColor = isExpired
        ? AppColors.error
        : isOverdue
        ? AppColors.warning
        : isUsed
        ? AppColors.textSecondary
        : AppColors.primary;

    final Color softBgColor = isExpired
        ? AppColors.error.withOpacity(0.08)
        : isOverdue
        ? AppColors.warning.withOpacity(0.08)
        : isUsed
        ? AppColors.textSecondary.withOpacity(0.08)
        : AppColors.primary.withOpacity(0.08);

    final IconData leadingIcon = isExpired
        ? LucideIcons.circleX
        : isOverdue
        ? LucideIcons.triangleAlert
        : isUsed
        ? LucideIcons.circleCheckBig
        : LucideIcons.packageCheck;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.packageDetail,
          arguments: {"packageId": item.lockerDetailId},
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: accentColor.withOpacity(0.18),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Package ID: ",
                          style: AppFonts.text11.medium.style.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: item.lockerDetailId?.toString() ?? "--",
                          style: AppFonts.text11.medium.style.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _statusChip(status),
              ],
            ),
            8.verticalSpace,
            Row(
              children: [
                Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: BoxDecoration(
                    color: softBgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    leadingIcon,
                    color: accentColor,
                    size: 18.sp,
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifier.getTitle(item),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.text14.semiBold.style.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      2.verticalSpace,
                      Text(
                        "on ${notifier.formatDate(item.createdOn)}",
                        style: AppFonts.text12.medium.style.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isUsed && !isExpired) ...[
              10.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: softBgColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isOverdue
                            ? "Overdue since ${notifier.formatDate(item.createdOn)}"
                            : "Pickup before ${notifier.formatDate(item.createdOn)}",
                        style: AppFonts.text10.medium.style.copyWith(
                          color: accentColor,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14.sp,
                      color: accentColor,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    final String key = status.toLowerCase();

    Color bgColor;
    Color textColor;

    switch (key) {
      case "used":
        bgColor = AppColors.textSecondary.withOpacity(0.12);
        textColor = AppColors.textSecondary;
        break;
      case "overdue":
        bgColor = AppColors.warning.withOpacity(0.12);
        textColor = AppColors.warning;
        break;
      case "expired":
        bgColor = AppColors.error.withOpacity(0.12);
        textColor = AppColors.error;
        break;
      default:
        bgColor = AppColors.primary.withOpacity(0.10);
        textColor = AppColors.primary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        status,
        style: AppFonts.text10.bold.style.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}