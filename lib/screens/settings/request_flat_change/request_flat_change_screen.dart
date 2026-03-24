import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/settings/request_flat_change/request_flat_change_notifier.dart';

class RequestFlatChangeScreen extends StatelessWidget {
  const RequestFlatChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestFlatChangeNotifier(),
      child: Consumer<RequestFlatChangeNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, RequestFlatChangeNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Request Flat Change",
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
              children: [
                _headerCard(),
                16.verticalSpace,
                _formCard(
                  children: [
                    _fieldTitle("Current Unit"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.currentUnitController,
                      hintText: "Current unit",
                      icon: LucideIcons.house,
                      readOnly: true,
                    ),
                    14.verticalSpace,
                    _fieldTitle("Requested Unit"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.requestedUnitController,
                      hintText: "Enter requested unit",
                      icon: LucideIcons.housePlus,
                      validator: notifier.validateUnit,
                    ),
                    14.verticalSpace,
                    _fieldTitle("Building / Tower"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.buildingController,
                      hintText: "Enter building or tower",
                      icon: LucideIcons.building2,
                      validator: notifier.validateBuilding,
                    ),
                    14.verticalSpace,
                    _fieldTitle("Reason"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.reasonController,
                      hintText: "Enter the reason for change",
                      icon: LucideIcons.notepadText,
                      maxLines: 4,
                      validator: notifier.validateReason,
                    ),
                  ],
                ),
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
              LucideIcons.housePlus,
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
                  "Flat Change Request",
                  style: AppFonts.text16.bold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Submit a request to update your assigned unit",
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
    bool readOnly = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
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
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: 18.sp,
        ),
        filled: true,
        fillColor: readOnly ? AppColors.backgroundField : AppColors.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
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
    );
  }

  Widget _submitButton(BuildContext context, RequestFlatChangeNotifier notifier) {
    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: ElevatedButton(
        onPressed: () => notifier.submitRequest(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          "Submit Request",
          style: AppFonts.text14.semiBold.style.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}