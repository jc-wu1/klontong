import 'package:flutter/material.dart';

import 'klontong_app.dart';
import 'src/core/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const KlontongApp());
}
