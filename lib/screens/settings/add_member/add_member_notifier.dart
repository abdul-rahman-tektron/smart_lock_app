import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';

class AddMemberNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String selectedRelationship = 'Family';
  String selectedAccessType = 'Pickup Only';

  final List<String> relationshipOptions = [
    'Family',
    'Friend',
    'Housemate',
    'Other',
  ];

  final List<String> accessTypeOptions = [
    'Full Access',
    'Pickup Only',
    'Temporary Access',
  ];

  void updateRelationship(String? value) {
    if (value == null) return;
    selectedRelationship = value;
    notifyListeners();
  }

  void updateAccessType(String? value) {
    if (value == null) return;
    selectedAccessType = value;
    notifyListeners();
  }

  String? validateName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Full name is required';
    if (text.length < 3) return 'Enter a valid full name';
    return null;
  }

  String? validatePhone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Mobile number is required';
    if (text.length < 8) return 'Enter a valid mobile number';
    return null;
  }

  String? validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email address is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(text)) return 'Enter a valid email address';
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

  Future<void> addMember(BuildContext context) async {
    if (!validateAndSave()) return;

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Member added successfully')),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    notesController.dispose();
    super.dispose();
  }
}