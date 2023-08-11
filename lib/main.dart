import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'jacksi_ltd_app.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const QualityCashierApp(),
  //   ),
  // );
  runApp(
    const JacksiLtdApp(),
  );
}
