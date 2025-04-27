import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'services/user_session_provider.dart';

void main() {
  // Lock orientation to portrait only.
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserSessionProvider()..loadUserSession(),
      child: const MyApp(),
    ),
  );
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
