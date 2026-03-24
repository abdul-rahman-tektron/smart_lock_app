import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate_border/flutter_animate_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/package_detail/package_detail_notifier.dart';

class PackageDetailScreen extends StatelessWidget {
  final String? packageId;

  const PackageDetailScreen({
    super.key,
    required this.packageId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PackageDetailNotifier(packageId ?? ""),
      child: Consumer<PackageDetailNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PackageDetailNotifier notifier) {
    final Color accentColor = notifier.isExpired
        ? AppColors.error
        : notifier.isOverdue
        ? AppColors.warning
        : notifier.isUsed
        ? AppColors.textSecondary
        : AppColors.primary;

    final Color softBgColor = notifier.isExpired
        ? AppColors.error.withOpacity(0.08)
        : notifier.isOverdue
        ? AppColors.warning.withOpacity(0.08)
        : notifier.isUsed
        ? AppColors.textSecondary.withOpacity(0.08)
        : AppColors.primary.withOpacity(0.08);

    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Package Details",
          style: AppFonts.text16.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: notifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : notifier.packageDetail == null
            ? Center(
          child: Text(
            "Package not found",
            style: AppFonts.text14.medium.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        )
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            children: [
              _heroSection(notifier, accentColor, softBgColor),
              14.verticalSpace,
              _contentSheet(context, notifier, accentColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroSection(
      PackageDetailNotifier notifier,
      Color accentColor,
      Color softBgColor,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor,
            _darken(accentColor),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              notifier.isExpired
                  ? LucideIcons.circleX
                  : notifier.isOverdue
                  ? LucideIcons.triangleAlert
                  : notifier.isUsed
                  ? LucideIcons.circleCheckBig
                  : LucideIcons.packageCheck,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notifier.title,
                  style: AppFonts.text16.semiBold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                5.verticalSpace,
                Text(
                  "Package ID: ${notifier.referenceId}",
                  style: AppFonts.text12.medium.style.copyWith(
                    color: AppColors.white.withOpacity(0.88),
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Delivered on ${notifier.formatDate(notifier.deliveredAt)}",
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

  Widget _contentSheet(
      BuildContext context,
      PackageDetailNotifier notifier,
      Color accentColor,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!notifier.isUsed) ...[
          _qrCard(notifier, accentColor),
          18.verticalSpace,
          _pickupCodeStrip(context, notifier, accentColor),
        ],
        18.verticalSpace,
        Text(
          "Package Information",
          style: AppFonts.text14.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        10.verticalSpace,
        _detailRow("Package Status", notifier.status, accentColor),
        _divider(),
        _detailRow("Package ID", notifier.referenceId, AppColors.textPrimary),
        _divider(),
        _detailRow("Delivered On", notifier.formatDate(notifier.deliveredAt), AppColors.textPrimary),
        _divider(),
        _detailRow("Delivered By", notifier.deliveredBy, AppColors.textPrimary),
        _divider(),
        _detailRow(notifier.secondLabel, notifier.formatDate(notifier.statusAt), AppColors.textPrimary),
        _divider(),
        _detailRow("Collected By", notifier.receiver, AppColors.textPrimary),
        _divider(),
        _detailRow("Package Box Size", notifier.lockerSize, AppColors.textPrimary),
        16.verticalSpace,
        _noteInline(),
      ],
    );
  }

  Widget _pickupCodeStrip(
      BuildContext context,
      PackageDetailNotifier notifier,
      Color accentColor,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundField,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pickup Code",
                  style: AppFonts.text11.medium.style.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                4.verticalSpace,
                Text(
                  notifier.pickupCode,
                  style: AppFonts.text20.bold.style.copyWith(
                    color: accentColor,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: notifier.pickupCode));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pickup code copied")),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.copy,
                    size: 15.sp,
                    color: AppColors.primary,
                  ),
                  6.horizontalSpace,
                  Text(
                    "Copy",
                    style: AppFonts.text11.semiBold.style.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qrCard(PackageDetailNotifier notifier, Color accentColor) {
    return Column(
      children: [
        FlutterAnimateBorder(
          controller: FlutterAnimateBorderController(isLoading: true),
          lineThickness: 2,
          lineWidth: 55,
          linePadding: 3,
          cornerRadius: 22.r,
          gradient: LinearGradient(
            stops: const [0.0, 0.3, 0.7, 1.0],
            colors: [
              accentColor.withOpacity(0.0),
              accentColor.withOpacity(0.8),
              accentColor.withOpacity(0.8),
              accentColor.withOpacity(0.0),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: accentColor.withOpacity(0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: QrImageView(
                data: notifier.qrValue,
                version: QrVersions.auto,
                size: 180.w,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value, Color valueColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppFonts.text12.medium.style.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppFonts.text12.semiBold.style.copyWith(
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noteInline() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          LucideIcons.info,
          size: 17.sp,
          color: AppColors.primary,
        ),
        8.horizontalSpace,
        Expanded(
          child: Text(
            "Use the QR code or pickup code at the locker to collect your package. Contact support if you face any issue.",
            style: AppFonts.text12.medium.style.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      color: AppColors.primary.withOpacity(0.08),
    );
  }

  Widget _heroStatusChip(String status) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.16),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          status,
          style: AppFonts.text10.bold.style.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color _darken(Color color) {
    final hsl = HSLColor.fromColor(color);
    final darker = hsl.withLightness((hsl.lightness - 0.10).clamp(0.0, 1.0));
    return darker.toColor();
  }
}