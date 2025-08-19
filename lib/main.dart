import 'package:chemical_compounds/app.dart';
import 'package:chemical_compounds/flavors/configure/build_config.dart';
import 'package:chemical_compounds/flavors/configure/env_config.dart';
import 'package:chemical_compounds/flavors/configure/environment.dart';
import 'package:chemical_compounds/flavors/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> appMain({required Environment appFlavor}) async {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = appFlavor;
  await F.loadEnvironment();

  EnvConfig prodConfig = EnvConfig(
    appName: dotenv.env['APP_NAME'] ?? "Chemical Compounds",
    baseUrl: dotenv.env['API'] ?? '',
  );

  BuildConfig.instantiate(envType: F.appFlavor!, envConfig: prodConfig);

  runApp(const App());
}
