import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesantren_management/config/router.dart' as router;
import 'package:pesantren_management/config/theme.dart' as theme;

class PesantrenManagementApp extends ConsumerWidget {
  const PesantrenManagementApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Pesantren Management',
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      routerConfig: router.goRouter,
    );
  }
}
