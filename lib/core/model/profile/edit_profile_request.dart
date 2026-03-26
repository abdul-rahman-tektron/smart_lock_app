import 'dart:io';

class EditProfileRequest {
  final int tenantId;
  final String fullName;
  final String phoneNumber;
  final String? password;
  final File? profileImage;

  EditProfileRequest({
    required this.tenantId,
    required this.fullName,
    required this.phoneNumber,
    this.password,
    this.profileImage,
  });
}