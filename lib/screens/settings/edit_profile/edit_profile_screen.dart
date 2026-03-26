import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/res/api_constants.dart';
import 'package:smart_lock_app/res/colors.dart';
import 'package:smart_lock_app/res/fonts.dart';
import 'package:smart_lock_app/screens/settings/edit_profile/edit_profile_notifier.dart';
import 'package:smart_lock_app/screens/settings/edit_profile/profile_camera_capture_screen.dart';

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
        title: Column(
          children: [
            Text(
              "Edit Profile",
              style: AppFonts.text16.semiBold.style.copyWith(color: AppColors.textPrimary),
            ),
            5.verticalSpace,
            Text(
              "Update your personal details",
              style: AppFonts.text12.medium.style.copyWith(
                color: AppColors.textPrimary.withOpacity(0.85),
              ),
            ),
          ],
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
                _profileImageSection(context, notifier),
                10.verticalSpace,
                _infoNote(),
                10.verticalSpace,
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
            child: Icon(LucideIcons.userPen, color: AppColors.white, size: 24.sp),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Information",
                  style: AppFonts.text16.bold.style.copyWith(color: AppColors.white),
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

  Widget _profileImageSection(BuildContext context, EditProfileNotifier notifier) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
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
      child: Column(
        children: [
          Text("Profile Photo", style: AppFonts.text14.bold.style.copyWith(color: AppColors.white)),
          12.verticalSpace,
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundField,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: notifier.selectedProfileImage != null
                            ? Image.file(notifier.selectedProfileImage!, fit: BoxFit.cover)
                            : (notifier.existingProfileImage?.isNotEmpty ?? false)
                            ? Image.network(
                                "${ApiConstants.apiImageUrl}${notifier.existingProfileImage!}",
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  LucideIcons.userRound,
                                  size: 36.sp,
                                  color: AppColors.textSecondary,
                                ),
                              )
                            : Icon(LucideIcons.userRound, size: 36.sp, color: AppColors.textSecondary),
                      ),
                      Positioned(
                        right: -5,
                        bottom: -5,
                        child: InkWell(
                          onTap: () => _showImagePickerOptions(context, notifier),
                          borderRadius: BorderRadius.circular(30.r),
                          child: Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.white, width: 1.5),
                            ),
                            child: Icon(LucideIcons.pencil, color: AppColors.white, size: 12.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (notifier.selectedProfileImage != null) ...[
                    10.verticalSpace,
                    GestureDetector(
                      onTap: notifier.removeSelectedImage,
                      child: Text(
                        "Remove Photo",
                        style: AppFonts.text12.semiBold.style.copyWith(color: Colors.red),
                      ),
                    ),
                  ]
                ],
              ),
              15.horizontalSpace,
              Expanded(
                child: Text(
                  "Upload a clear, front-facing photo. Keep your face centered inside the frame and avoid side angles, tilted poses, dark lighting, or cropped faces.",
                  textAlign: TextAlign.center,
                  style: AppFonts.text11.medium.style.copyWith(color: AppColors.white.withOpacity(0.85)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context, EditProfileNotifier notifier) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.all(18.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              16.verticalSpace,
              Text(
                "Choose Profile Photo",
                style: AppFonts.text16.semiBold.style.copyWith(color: AppColors.textPrimary),
              ),
              8.verticalSpace,
              Text(
                "Use a centered, front-facing image with good lighting.",
                textAlign: TextAlign.center,
                style: AppFonts.text12.medium.style.copyWith(color: AppColors.textSecondary),
              ),
              18.verticalSpace,
              _sheetOption(
                icon: LucideIcons.imagePlus,
                title: "Upload from Gallery",
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await notifier.pickFromGallery(context);
                },
              ),
              10.verticalSpace,
              _sheetOption(
                icon: LucideIcons.camera,
                title: "Take from Camera",
                onTap: () async {
                  Navigator.pop(sheetContext);

                  final file = await Navigator.push<File>(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileCameraCaptureScreen()),
                  );

                  if (file != null) {
                    notifier.setCapturedImage(file);
                  }
                },
              ),
              10.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Widget _sheetOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundField,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20.sp),
            12.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: AppFonts.text14.medium.style.copyWith(color: AppColors.textPrimary),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondary),
          ],
        ),
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
          BoxShadow(color: AppColors.shadowColor, blurRadius: 10, offset: Offset(0, 3)),
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
        style: AppFonts.text12.medium.style.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType = TextInputType.text,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      style: AppFonts.text14.medium.style.copyWith(color: AppColors.textPrimary),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.text12.regular.style.copyWith(
          color: AppColors.textSecondary.withOpacity(0.75),
        ),
        prefixIcon: Icon(icon, color: AppColors.primary, size: 18.sp),
        filled: true,
        fillColor: readOnly ? AppColors.backgroundField : AppColors.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.08)),
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
              "Email address and flat details are managed separately for security and access control.",
              style: AppFonts.text12.medium.style.copyWith(color: AppColors.primaryDark),
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
        onPressed: notifier.isLoading ? null : () => notifier.saveProfile(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
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
                "Save Changes",
                style: AppFonts.text14.semiBold.style.copyWith(color: AppColors.white),
              ),
      ),
    );
  }
}
