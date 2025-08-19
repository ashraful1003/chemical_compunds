class AppValues {
  static final AppValues _instance = AppValues._internal();

  factory AppValues() {
    return _instance;
  }

  AppValues._internal();

  static const int loggerLineLength = 120;
  static const int loggerErrorMethodCount = 8;
  static const int loggerMethodCount = 2;
}
