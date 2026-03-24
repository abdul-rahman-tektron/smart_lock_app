import 'package:flutter/material.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';

class RequestFlatChangeNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController currentUnitController = TextEditingController();
  final TextEditingController requestedUnitController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  RequestFlatChangeNotifier() {
    currentUnitController.text = "Unit A-1204 • Aldar Residence";
  }

  String? validateUnit(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Requested unit is required';
    return null;
  }

  String? validateBuilding(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Building / Tower is required';
    return null;
  }

  String? validateReason(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Reason is required';
    if (text.length < 5) return 'Please enter a valid reason';
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

  Future<void> submitRequest(BuildContext context) async {
    if (!validateAndSave()) return;

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Flat change request submitted')),
    );
  }

  @override
  void dispose() {
    currentUnitController.dispose();
    requestedUnitController.dispose();
    buildingController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}