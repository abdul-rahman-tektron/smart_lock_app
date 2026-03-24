class Env {
  /// default = prod
  static const String mode =
  String.fromEnvironment('ENV', defaultValue: 'prod'); // dev | prod

  static bool get isDev => mode == 'dev';
  static bool get isProd => mode == 'prod';

  /// Optional override from IDE:
  /// --dart-define=BASE_HOST=...
  static const String baseHostOverride =
  String.fromEnvironment('BASE_HOST', defaultValue: '');

  static String pickHost({
    required String prodHost,
    required String devHost,
  }) {
    if (baseHostOverride.isNotEmpty) return baseHostOverride;
    return isDev ? devHost : prodHost;
  }

  static String get environmentLabel => isDev ? 'Dev' : 'Prod';
}