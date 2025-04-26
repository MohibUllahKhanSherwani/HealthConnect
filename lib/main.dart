import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  // Lock orientation to portrait only.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Doctor Connect',
      theme: lightTheme,
      routerConfig: appRouter,
    );
  }
}
