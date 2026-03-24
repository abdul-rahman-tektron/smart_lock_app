import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';

class EditProfileNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  EditProfileNotifier() {
    _loadDummyData();
  }

  void _loadDummyData() {
    fullNameController.text = "Abdul Rahman";
    emailController.text = "abdulrahman@email.com";
    mobileController.text = "+971 50 123 4567";
    unitController.text = "Unit A-1204 • Aldar Residence";
  }

  String? validateName(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Full name is required";
    if (text.length < 3) return "Enter a valid full name";
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

  Future<void> saveProfile(BuildContext context) async {
    if (!validateAndSave()) return;

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated successfully"),
      ),
    );
  }

  String? validatePhone(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Mobile number is required";
    if (text.length < 8) return "Enter a valid mobile number";
    return null;
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