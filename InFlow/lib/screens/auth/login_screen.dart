import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';
import 'package:inflow/screens/auth/register_screen.dart';
import 'package:inflow/screens/main_navigation.dart';
import 'package:inflow/widgets/inflow_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark 
              ? [AppColors.background, const Color(0xFF1A1A2E)]
              : [AppColors.lBackground, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // InFlow Logo (3D/Gradient Style)
                const InFlowLogo(size: 130),
                const SizedBox(height: 24),
                Text(
                  'InFlow',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: isDark ? Colors.white : AppColors.lTextBody,
                    letterSpacing: -1,
                    fontSize: 40,
                  ),
                ),
                Text(
                  'Smart assistant for freelancers',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textDim : AppColors.lTextDim,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 60),
                
                // Login Form
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 8,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: isDark ? AppColors.textDim : AppColors.lTextDim),
                      children: [
                        const TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
