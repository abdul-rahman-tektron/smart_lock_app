import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/settings/help_support_request.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
import 'package:smart_lock_app/utils/widgets/custom_toast.dart';

class HelpSupportNotifier extends BaseChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController complaintController = TextEditingController();

  bool isLoading = false;

  String get _formattedNow =>
      DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(DateTime.now());

  String? validateComplaint(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Please enter your complaint";
    if (text.length < 10) return "Please enter a more detailed complaint";
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

  Future<void> submitComplaint(BuildContext context) async {
    if (!validateAndSave()) return;

    getSavedUser();
    final tenantId = user?.tenantId;

    if (tenantId == null) {
      ToastHelper.showError("Tenant information is missing", context: context);
      return;
    }

    FocusScope.of(context).unfocus();
    isLoading = true;
    notifyListeners();

    try {
      final request = HelpSupportRequest(
        flatId: tenantId, // backend field name flatId, but sending tenantId
        complaint: complaintController.text.trim(),
        complaintDate: _formattedNow,
        status: "Open",
      );

      final result = await CommonRepository.instance.apiHelpSupport(request);

      if (result is CommonResponse && result.success == true) {
        if (!context.mounted) return;

        ToastHelper.showSuccess(
          result.message ?? "Complaint submitted successfully",
          context: context,
        );

        complaintController.clear();
        Navigator.pop(context);
      } else if (result is ErrorResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Failed to submit complaint",
          context: context,
        );
      } else if (result is CommonResponse) {
        if (!context.mounted) return;
        ToastHelper.showError(
          result.message ?? "Failed to submit complaint",
          context: context,
        );
      } else {
        if (!context.mounted) return;
        ToastHelper.showError(
          "Failed to submit complaint",
          context: context,
        );
      }
    } catch (_) {
      if (!context.mounted) return;
      ToastHelper.showError("Something went wrong", context: context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }
}