import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_lock_app/screens/common/bottom_screen/bottom_screen.dart';
import 'package:smart_lock_app/screens/common/not_found.dart';
import 'package:smart_lock_app/screens/home/home_screen.dart';
import 'package:smart_lock_app/screens/login/login_screen.dart';
import 'package:smart_lock_app/screens/otp_verification/otp_verification_screen.dart';
import 'package:smart_lock_app/screens/package_detail/package_detail_screen.dart';
import 'package:smart_lock_app/screens/package_history/package_history_screen.dart';
import 'package:smart_lock_app/screens/reset_password/reset_password_screen.dart';
import 'package:smart_lock_app/screens/settings/add_member/add_member_screen.dart';
import 'package:smart_lock_app/screens/settings/change_password/change_password_screen.dart';
import 'package:smart_lock_app/screens/settings/edit_profile/edit_profile_screen.dart';
import 'package:smart_lock_app/screens/settings/help_support/help_support_screen.dart';
import 'package:smart_lock_app/screens/settings/manage_member/manage_member_screen.dart';
import 'package:smart_lock_app/screens/settings/request_flat_change/request_flat_change_screen.dart';
import 'package:smart_lock_app/screens/settings/settings_screen.dart';
import 'package:smart_lock_app/utils/enums.dart';

class AppRoutes {
  /// 🔐 Auth
  static const launcher = '/launcher';
  static const String login = '/login';

  static const String bottomScreen = '/bottom-screen';

  static const String home = '/home';
  static const String settings = '/settings';
  static const String resetPassword = '/reset-password';
  static const String otpVerification = '/otp-verification';
  static const String packageDetail = '/package-detail';
  static const String helpSupport = '/help-support';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String addMember = '/add-member';
  static const String manageMember = '/manage-member';
  static const String packageHistory = '/package-history';
  static const String requestFlatChange = '/request-flat-change';

  /// ❗ Error
  static const String networkError = '/network-error';
  static const String notFound = '/not-found';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget screen;

    switch (settings.name) {

      case AppRoutes.login:
        screen = const LoginScreen();
        break;

      case AppRoutes.bottomScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final currentIndex = args['currentIndex'] as int?;
        screen = BottomScreen(currentIndex: currentIndex);
        break;

      case AppRoutes.home:
        screen = const HomeScreen();
        break;

      case AppRoutes.settings:
        screen = const SettingsScreen();
        break;

      case AppRoutes.changePassword:
        screen = const ChangePasswordScreen();
        break;

      case AppRoutes.editProfile:
        screen = const EditProfileScreen();
        break;

      case AppRoutes.addMember:
        screen = const AddMemberScreen();
        break;

      case AppRoutes.manageMember:
        screen = const ManageMembersScreen();
        break;

      case AppRoutes.requestFlatChange:
        screen = const RequestFlatChangeScreen();
        break;

      case AppRoutes.resetPassword:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final email = args['email'] as String?;
        final otp = args['otp'] as String?;
        screen = ResetPasswordScreen(email: email, otp: otp,);
        break;

      case AppRoutes.otpVerification:
        final args = settings.arguments as String;
        screen = OtpVerificationScreen(email: args);
        break;

      case AppRoutes.packageHistory:
        screen = PackageHistoryScreen();
        break;

      case AppRoutes.packageDetail:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final packageId = args['packageId'] as int?;
        screen = PackageDetailScreen(packageId: packageId);
        break;

      case AppRoutes.helpSupport:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      // Default
      default:
        screen = const NotFoundScreen();
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: defaultPageTransition,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}

Widget defaultPageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: animation,
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: (1 - animation.value) * 5,
        sigmaY: (1 - animation.value) * 5,
      ),
      child: child,
    ),
  );
}
