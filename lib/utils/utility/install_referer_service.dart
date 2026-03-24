import 'dart:io';
import 'package:stack_deferred_link/stack_deferred_link.dart';

class InstallReferrerService {
  static Future<String?> getToken() async {
    if (!Platform.isAndroid) return null;

    try {
      final info = await StackDeferredLink.getInstallReferrerAndroid();
      return info.getParam('token');
    } catch (_) {
      return null;
    }
  }
}