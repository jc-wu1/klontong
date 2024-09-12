import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'klontong_app.dart';
import 'src/core/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  /// Disable device rotation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const KlontongApp());
}
