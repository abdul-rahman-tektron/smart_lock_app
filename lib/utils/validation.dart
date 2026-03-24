import 'package:flutter/material.dart';
import 'package:smart_lock_app/utils/regex.dart';

class Validations {
  Validations._();

  static String? requiredField(BuildContext context, String? value, {String? customMessage}) {
    if (value == null || value.trim().isEmpty) {
      return customMessage ?? "Field is required";
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    if (!RegExp(RegexPatterns.email).hasMatch(value.trim())) {
      return "Invalid Email Format";
    }
    return null;
  }

  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
  }
}
