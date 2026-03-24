import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // prevent instantiation

  /// PRIMARY BRAND (Enterprise Teal)
  static const primary = Color(0xFF008C8A);       // Main brand color
  static const primaryDark = Color(0xFF006F6E);   // For headers / pressed state
  static const primaryLight = Color(0xFFE6F7F7);  // Soft background tint
  static const primaryAccent = Color(0xFF00B3B0); // Highlights / glow

  /// SECONDARY (Neutral Support)
  static const secondary = Color(0xFF008C8A);     // Deep navy (professional depth)
  static const secondaryLight = Color(0xFF00B3B0);

  /// BACKGROUNDS
  static const background = Color(0xFFFFFFFF);        // Main kiosk background
  static const backgroundSoft = Color(0xFFF4F8F8);    // Subtle section background
  static const backgroundField = Color(0xFFEAF3F3);   // Input field background

  /// TEXT
  static const textPrimary = Color(0xFF1A1A1A);   // Main text
  static const textSecondary = Color(0xFF6B7280); // Subtle text
  static const textOnPrimary = Color(0xFFFFFFFF); // Text on teal buttons

  /// STATES
  static const error = Color(0xFFBE3D2A);
  static const success = Color(0xFF1F8A70);
  static const warning = Color(0xFFF59E0B);

  /// UI HELPERS
  static const white = Color(0xFFFFFFFF);
  static const transparent = Colors.transparent;
  static const shadowColor = Color(0x14000000); // Soft modern shadow (8% black)
}