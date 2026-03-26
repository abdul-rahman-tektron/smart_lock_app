import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/core/model/profile/edit_profile_request.dart';
import 'package:smart_lock_app/core/model/profile/get_profile_response.dart';
import 'package:smart_lock_app/core/notifier/user_cache_notifier.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/utils/widgets/custom_toast.dart';

class EditProfileNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  bool isLoading = false;
  File? selectedProfileImage;

  String? existingProfileImage;

  final ImagePicker _picker = ImagePicker();

  EditProfileNotifier() {
    _loadUserData();
  }

  void _loadUserData() {
    getSavedUser();
    fullNameController.text = user?.fullName ?? "";
    emailController.text = user?.email ?? "";
    mobileController.text = user?.phoneNumber ?? "";
    unitController.text = user?.flatId?.toString() ?? "";
    existingProfileImage = user?.profileImage;
  }

  String? validateName(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Full name is required";
    if (text.length < 3) return "Enter a valid full name";
    return null;
  }

  String? validatePhone(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Mobile number is required";
    if (text.length < 8) return "Enter a valid mobile number";
    return null;
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> pickFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedProfileImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (_) {
      if (!context.mounted) return;
      ToastHelper.showError("Failed to pick image", context: context);
    }
  }

  void setCapturedImage(File file) {
    selectedProfileImage = file;
    notifyListeners();
  }

  void removeSelectedImage() {
    selectedProfileImage = null;
    notifyListeners();
  }

  Future<void> saveProfile(BuildContext context) async {
    if (!validateAndSave()) return;

    getSavedUser();
    final tenantId = user?.tenantId;

    if (tenantId == null) {
      ToastHelper.showError("Tenant id is missing", context: context);
      return;
    }

    FocusScope.of(context).unfocus();
    isLoading = true;
    notifyListeners();

    try {
      final request = EditProfileRequest(
        tenantId: tenantId,
        fullName: fullNameController.text.trim(),
        phoneNumber: mobileController.text.trim(),
        profileImage: selectedProfileImage,
      );

      final result = await CommonRepository.instance.apiEditProfile(request);

      if (result is CommonResponse && result.success == true) {
        if (!context.mounted) return;

        final profileResult = await CommonRepository.instance.apiGetProfile(tenantId);

        if (!context.mounted) return;

        if (profileResult is GetProfileResponse &&
            profileResult.success == true &&
            profileResult.data != null) {
          getSavedUser();

          if (user != null) {
            final updatedUser = UserData.fromJson(user!.toJson());

            updatedUser.fullName = profileResult.data?.fullName;
            updatedUser.email = profileResult.data?.email;
            updatedUser.phoneNumber = profileResult.data?.phoneNumber;
            updatedUser.profileImage = profileResult.data?.profileImage;
            updatedUser.flatId = profileResult.data?.flatId;

            await context.read<UserCacheNotifier>().setUser(updatedUser);
          }

          ToastHelper.showSuccess(
            result.message ?? "Profile updated successfully",
            context: context,
          );

          Navigator.pop(context, true);
        } else if (profileResult is ErrorResponse) {
          ToastHelper.showError(
            profileResult.message ?? "Profile updated, but failed to refresh profile data",
            context: context,
          );
          Navigator.pop(context, true);
        } else {
          ToastHelper.showError(
            "Profile updated, but failed to refresh profile data",
            context: context,
          );
          Navigator.pop(context, true);
        }
      }
    } catch (_) {
      if (!context.mounted) return;
      ToastHelper.showError(
        "Something went wrong",
        context: context,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    unitController.dispose();
    super.dispose();
  }
}