import 'package:chemical_compounds/flavors/configure/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class F {
  static Environment? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Environment.development:
        return 'Chemical Compounds Dev';
      default:
        return 'Chemical Compounds';
    }
  }

  static Future<void> loadEnvironment() async {
    String fileName = 'assets/env/';
    switch (appFlavor) {
      case Environment.development:
        fileName += '.env.dev';
      default:
        fileName += '.env';
    }
    return dotenv.load(fileName: fileName);
  }
}
