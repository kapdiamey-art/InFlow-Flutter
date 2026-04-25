import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';
import 'package:inflow/screens/auth/login_screen.dart';

void main() {
  runApp(const InFlowApp());
}

class InFlowThemeManager extends InheritedWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeChanged;

  const InFlowThemeManager({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    required super.child,
  });

  static InFlowThemeManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InFlowThemeManager>();
  }

  @override
  bool updateShouldNotify(InFlowThemeManager oldWidget) => themeMode != oldWidget.themeMode;
}

class InFlowApp extends StatefulWidget {
  const InFlowApp({super.key});

  @override
  State<InFlowApp> createState() => _InFlowAppState();
}

class _InFlowAppState extends State<InFlowApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InFlowThemeManager(
      themeMode: _themeMode,
      onThemeChanged: _toggleTheme,
      child: MaterialApp(
        title: 'InFlow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: const LoginScreen(),
      ),
    );
  }
}
