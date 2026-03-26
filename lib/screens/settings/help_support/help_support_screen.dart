import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/settings/help_support/help_support_notifier.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HelpSupportNotifier(),
      child: Consumer<HelpSupportNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HelpSupportNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Help & Support",
          style: AppFonts.text16.semiBold.style.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Form(
            key: notifier.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerCard(),
                16.verticalSpace,
                _formCard(
                  children: [
                    _fieldTitle("Complaint Details"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.complaintController,
                      hintText: "Describe your issue in detail...",
                      icon: LucideIcons.messageSquareWarning,
                      maxLines: 8,
                      validator: notifier.validateComplaint,
                    ),
                  ],
                ),
                12.verticalSpace,
                _infoNote(),
                18.verticalSpace,
                _submitButton(context, notifier),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
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
              color: AppColors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              LucideIcons.badgeQuestionMark,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Need Help?",
                  style: AppFonts.text16.bold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Submit your issue and our support team will review it.",
                  style: AppFonts.text12.medium.style.copyWith(
                    color: AppColors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.08)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _fieldTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppFonts.text12.medium.style.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: AppFonts.text14.medium.style.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.text12.regular.style.copyWith(
          color: AppColors.textSecondary.withOpacity(0.75),
        ),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.16)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        ),
      ),
    );
  }

  Widget _infoNote() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.info, color: AppColors.primary, size: 18.sp),
          8.horizontalSpace,
          Expanded(
            child: Text(
              "Please include full details such as locker issue, package issue, access problem, or any important context to help us resolve it faster.",
              style: AppFonts.text12.medium.style.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context, HelpSupportNotifier notifier) {
    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: ElevatedButton(
        onPressed: notifier.isLoading
            ? null
            : () => notifier.submitComplaint(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: notifier.isLoading
            ? SizedBox(
          height: 18.h,
          width: 18.h,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        )
            : Text(
          "Submit Request",
          style: AppFonts.text14.semiBold.style.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}