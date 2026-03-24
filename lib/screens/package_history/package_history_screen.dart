import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/package_history/package_history_notifier.dart';
import 'package:smart_lock_app/utils/routes.dart';

class PackageHistoryScreen extends StatelessWidget {
  const PackageHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PackageHistoryNotifier(),
      child: Consumer<PackageHistoryNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PackageHistoryNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "My Packages",
          style: AppFonts.text16.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          children: [
            _filterCard(context, notifier),
            12.verticalSpace,
            _searchAndStatusRow(context, notifier),
            12.verticalSpace,
            _tableCard(context, notifier),
            14.verticalSpace,
            _paginationSection(context, notifier),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _filterCard(BuildContext context, PackageHistoryNotifier notifier) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
      childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
      backgroundColor: AppColors.white,
      collapsedBackgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      iconColor: AppColors.primary,
      collapsedIconColor: AppColors.primary,
      title: Text(
        "Filter Packages",
        style: AppFonts.text14.semiBold.style.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      children: [
        _dateField(
          context: context,
          controller: notifier.fromDateController,
          title: "From Date",
          onTap: () => notifier.pickFromDate(context),
        ),
        10.verticalSpace,
        _dateField(
          context: context,
          controller: notifier.toDateController,
          title: "To Date",
          onTap: () => notifier.pickToDate(context),
        ),
        14.verticalSpace,
        _dropdownField(
          title: "Status",
          value: notifier.selectedStatus,
          items: notifier.statusOptions,
          onChanged: notifier.updateStatus,
        ),
        10.verticalSpace,
        _dropdownField(
          title: "Box Size",
          value: notifier.selectedBoxSize,
          items: notifier.boxSizeOptions,
          onChanged: notifier.updateBoxSize,
        ),
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _outlineButton(
              text: "Clear",
              onTap: notifier.clearFilters,
            ),
            10.horizontalSpace,
            _primaryButton(
              text: "Apply",
              onTap: notifier.applyFilters,
            ),
          ],
        ),
      ],
    );
  }

  Widget _searchAndStatusRow(
      BuildContext context,
      PackageHistoryNotifier notifier,
      ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: notifier.searchController,
            onChanged: notifier.onSearchChanged,
            style: AppFonts.text12.medium.style.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: "Search package ID",
              hintStyle: AppFonts.text12.regular.style.copyWith(
                color: AppColors.textSecondary.withOpacity(0.75),
              ),
              prefixIcon: Icon(
                LucideIcons.search,
                color: AppColors.primary,
                size: 18.sp,
              ),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 13.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _summaryStrip(PackageHistoryNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: _smallSummaryCard(
            title: "Active",
            count: notifier.activeCount.toString(),
            color: AppColors.primary,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _smallSummaryCard(
            title: "Overdue",
            count: notifier.overdueCount.toString(),
            color: AppColors.warning,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _smallSummaryCard(
            title: "Used",
            count: notifier.usedCount.toString(),
            color: AppColors.textSecondary,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _smallSummaryCard(
            title: "Expired",
            count: notifier.expiredCount.toString(),
            color: AppColors.error,
          ),
        ),
      ],
    );
  }

  Widget _smallSummaryCard({
    required String title,
    required String count,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: AppFonts.text16.bold.style.copyWith(
              color: color,
            ),
          ),
          4.verticalSpace,
          Text(
            title,
            style: AppFonts.text11.medium.style.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCard(BuildContext context, PackageHistoryNotifier notifier) {
    final rows = notifier.currentPageItems;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.08),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Scrollbar(
          controller: notifier.horizontalScrollController,
          thumbVisibility: true,
          thickness: 4,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: notifier.horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 760.w),
              child: DataTable(
                headingRowHeight: 44.h,
                dataRowMinHeight: 56.h,
                dataRowMaxHeight: 62.h,
                columnSpacing: 18.w,
                headingRowColor: MaterialStateProperty.resolveWith(
                      (_) => AppColors.primary,
                ),
                headingTextStyle: AppFonts.text12.bold.style.copyWith(
                  color: AppColors.white,
                ),
                columns: const [
                  DataColumn(label: Text("Package ID")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Delivered On")),
                  DataColumn(label: Text("Timeline")),
                  DataColumn(label: Text("Box Size")),
                  DataColumn(label: Text("Receiver")),
                ],
                rows: rows.isEmpty
                    ? [
                  DataRow(
                    cells: [
                      DataCell(
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: Text(
                            "No packages found",
                            style: AppFonts.text12.medium.style.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      const DataCell(SizedBox()),
                      const DataCell(SizedBox()),
                      const DataCell(SizedBox()),
                      const DataCell(SizedBox()),
                      const DataCell(SizedBox()),
                    ],
                  ),
                ]
                    : rows.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.packageDetail,
                              arguments: {
                                "packageId": item.referenceId,
                              },
                            );
                          },
                          child: Text(
                            item.referenceId,
                            style: AppFonts.text12.semiBold.style.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      DataCell(_statusChip(item.status)),
                      DataCell(
                        Text(
                          notifier.formatDate(item.deliveredAt),
                          style: AppFonts.text12.medium.style.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          notifier.timelineLabel(item),
                          style: AppFonts.text12.medium.style.copyWith(
                            color: notifier.timelineColor(item),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.lockerSize,
                          style: AppFonts.text12.medium.style.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.receiver,
                          style: AppFonts.text12.medium.style.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _paginationSection(
      BuildContext context,
      PackageHistoryNotifier notifier,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Records: ${notifier.filteredPackages.length}",
          style: AppFonts.text12.medium.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _pageButton(
              icon: Icons.chevron_left_rounded,
              enabled: notifier.currentPage > 1,
              onTap: notifier.goToPreviousPage,
            ),
            Text(
              "Page ${notifier.currentPage} of ${notifier.totalPages}",
              style: AppFonts.text12.medium.style.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            _pageButton(
              icon: Icons.chevron_right_rounded,
              enabled: notifier.currentPage < notifier.totalPages,
              onTap: notifier.goToNextPage,
            ),
          ],
        ),
      ],
    );
  }

  Widget _pageButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 38.h,
      width: 42.w,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.35),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    final key = status.toLowerCase();

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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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

  Widget _dateField({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.text12.medium.style.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        8.verticalSpace,
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          style: AppFonts.text12.medium.style.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: "Select date",
            hintStyle: AppFonts.text12.regular.style.copyWith(
              color: AppColors.textSecondary.withOpacity(0.75),
            ),
            prefixIcon: Icon(
              LucideIcons.calendarDays,
              color: AppColors.primary,
              size: 18.sp,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdownField({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.text12.medium.style.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        8.verticalSpace,
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          style: AppFonts.text12.medium.style.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 14.h,
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
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: AppFonts.text12.medium.style.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _primaryButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 42.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          text,
          style: AppFonts.text12.semiBold.style.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _outlineButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 42.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.primary.withOpacity(0.18),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          text,
          style: AppFonts.text12.semiBold.style.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}