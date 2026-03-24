import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/settings/edit_profile/edit_profile_notifier.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileNotifier(),
      child: Consumer<EditProfileNotifier>(
        builder: (context, notifier, _) => _buildBody(context, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, EditProfileNotifier notifier) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSoft,
        elevation: 0,
        surfaceTintColor: AppColors.backgroundSoft,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Edit Profile",
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
                    _fieldTitle("Full Name"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.fullNameController,
                      hintText: "Enter full name",
                      icon: LucideIcons.userRound,
                      validator: notifier.validateName,
                    ),
                    14.verticalSpace,
                    _fieldTitle("Email Address"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.emailController,
                      hintText: "Email address",
                      icon: LucideIcons.mail,
                      readOnly: true,
                    ),
                    14.verticalSpace,
                    _fieldTitle("Mobile Number"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.mobileController,
                      hintText: "Enter mobile number",
                      icon: LucideIcons.phone,
                      keyboardType: TextInputType.phone,
                      validator: notifier.validatePhone,
                    ),
                    14.verticalSpace,
                    _fieldTitle("Unit / Flat"),
                    8.verticalSpace,
                    _textField(
                      controller: notifier.unitController,
                      hintText: "Unit / Flat",
                      icon: LucideIcons.house,
                      readOnly: true,
                    ),
                  ],
                ),
                16.verticalSpace,
                _infoNote(),
                18.verticalSpace,
                _saveButton(context, notifier),
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
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
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
              LucideIcons.userPen,
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
                  "Profile Information",
                  style: AppFonts.text16.bold.style.copyWith(
                    color: AppColors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Update your personal details here",
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
        border: Border.all(
          color: AppColors.primary.withOpacity(0.08),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
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
    TextInputType? keyboardType = TextInputType.none,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      style: AppFonts.text14.medium.style.copyWith(
        color: AppColors.textPrimary,
      ),
      keyboardType: keyboardType,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.2,
          ),
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
        border: Border.all(
          color: AppColors.primary.withOpacity(0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.info,
            color: AppColors.primary,
            size: 18.sp,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              "Email address and flat details are managed separately for security and access control.",
              style: AppFonts.text12.medium.style.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context, EditProfileNotifier notifier) {
    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: ElevatedButton(
        onPressed: () => notifier.saveProfile(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          "Save Changes",
          style: AppFonts.text14.semiBold.style.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}