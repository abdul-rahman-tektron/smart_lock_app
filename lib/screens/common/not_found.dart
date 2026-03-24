import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/notifier/language_notifier.dart';
import 'package:smart_lock_app/utils/extensions.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404 - ${context.locale.pageNotFound}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(onPressed: () {
              final langNotifier = context.read<LanguageNotifier>();
              langNotifier.switchLanguage("ar");
            }, child: Text(context.locale.switchLng))
          ],
        ),
      ),
    );
  }
}