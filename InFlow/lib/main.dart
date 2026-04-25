import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';
import 'package:inflow/screens/auth/login_screen.dart';

void main() {
  runApp(const InFlowApp());
}

class InFlowApp extends StatelessWidget {
  const InFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
