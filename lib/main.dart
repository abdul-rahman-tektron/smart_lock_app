import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_lock_app/core/generated_locales/l10n.dart';
import 'package:smart_lock_app/core/notifier/language_notifier.dart';
import 'package:smart_lock_app/core/notifier/user_cache_notifier.dart';
import 'package:smart_lock_app/res/themes.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:smart_lock_app/utils/screen_size.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_lock_app/utils/utility/app_initializer.dart';

void main() async {
  await AppInitializer.initialize();
  final appData = await AppInitializer.loadUserData();

  runApp(
    MyApp(
      token: appData["token"],
      isLoggedIn: appData["isLoggedIn"] ?? false,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;
  final bool isLoggedIn;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({
    super.key,
    required this.token,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageNotifier>(
          create: (_) => LanguageNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserCacheNotifier(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final langNotifier = context.watch<LanguageNotifier>();

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: MyApp.navigatorKey,
                title: 'Smart Locker App',
                locale: langNotifier.locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                initialRoute: _resolveInitialRoute(),
                onGenerateRoute: AppRouter.onGenerateRoute,
                theme: AppThemes.lightTheme(
                  languageCode: langNotifier.locale.languageCode,
                ),
                builder: (context, child) {
                  ScreenSize.init(context);

                  final mediaQueryData = MediaQuery.of(context);
                  final pixelRatio = mediaQueryData.devicePixelRatio;
                  final textScale = pixelRatio > 3.0 ? 0.8 : 1.0;

                  return MediaQuery(
                    data: mediaQueryData.copyWith(textScaleFactor: textScale),
                    child: child ?? const SizedBox.shrink(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _resolveInitialRoute() {
    if (token != null && token!.isNotEmpty && isLoggedIn) {
      return AppRoutes.bottomScreen;
    }
    return AppRoutes.login;
  }
}