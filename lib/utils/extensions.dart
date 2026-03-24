import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lock_app/core/generated_locales/l10n.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}

extension StringExtensions on String {
  bool isArabic() {
    final arabicRegExp = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');
    return arabicRegExp.hasMatch(this);
  }
}

extension DateFormatExtension on DateTime {
  // Strong LTR embedding (more reliable than LRI/PDI in some widgets)
  String _ltrStrong(String s) => '\u202A$s\u202C'; // LRE ... PDF
  // Or: thin LTR mark
  String _ltrMark(String s) => '\u200E$s\u200E'; // LRM ... LRM

  String formatDateTime({bool withTime = false}) {
    final pattern = withTime ? 'dd/MM/yyyy, hh:mm a' : 'dd/MM/yyyy';
    final v = DateFormat(pattern, 'en_US').format(this);
    return _ltrStrong(v); // try this first
  }

  String formatFullDateTime() {
    final v = DateFormat('dd MMM yyyy, hh:mm a', 'en_US').format(this);
    return _ltrStrong(v);
  }

  String formatDate() {
    final v = DateFormat('dd MMM yyyy', 'en_US').format(this);
    return _ltrStrong(v);
  }

  String formatTime() {
    final v = DateFormat('hh:mm a', 'en_US').format(this);
    return _ltrStrong(v);
  }
}