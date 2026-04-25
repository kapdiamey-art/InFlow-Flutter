import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';
import 'package:inflow/screens/auth/login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // User Profile Header
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: Text('AD', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 16),
                  Text('Alex Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('alex.doe@example.com', style: TextStyle(color: AppColors.textDim)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Settings Sections
            _buildSettingsGroup(context, 'Business info', [
              const ListTile(
                leading: Icon(Icons.monetization_on_outlined, color: AppColors.textDim),
                title: Text('Default Hourly Rate'),
                trailing: SizedBox(
                  width: 80,
                  child: TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      hintText: '$50',
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.payment, color: AppColors.textDim),
                title: const Text('Payment Setup'),
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 24),

            _buildSettingsGroup(context, 'Automation & Notifications', [
              SwitchListTile(
                title: const Text('Auto-send Invoices'),
                subtitle: const Text('Send when project is finished', style: TextStyle(fontSize: 11)),
                value: true,
                onChanged: (val) {},
                secondary: const Icon(Icons.auto_fix_high, color: AppColors.accent),
              ),
              SwitchListTile(
                title: const Text('Payment Reminders'),
                subtitle: const Text('Auto-remind late clients', style: TextStyle(fontSize: 11)),
                value: true,
                onChanged: (val) {},
                secondary: const Icon(Icons.notifications_active_outlined, color: AppColors.primary),
              ),
            ]),

            const SizedBox(height: 48),

            // Logout Button
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text('Logout', style: TextStyle(color: AppColors.error)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(title, style: const TextStyle(color: AppColors.textDim, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
