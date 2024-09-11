import 'package:flutter/material.dart';

import 'src/features/home/presentation/home_page.dart';

class KlontongApp extends StatelessWidget {
  const KlontongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klontong Mobile Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
