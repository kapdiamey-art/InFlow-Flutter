import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';
import 'package:inflow/screens/auth/login_screen.dart';

class ProfileTab extends StatefulWidget {
  final bool isFullPage;
  const ProfileTab({super.key, this.isFullPage = false});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _autoSendInvoices = true;
  bool _whatsappReminders = false;
  final _upiController = TextEditingController(text: 'alex@upi');
  final _accountController = TextEditingController(text: '**** **** 5678');

  void _savePaymentInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Payment information saved successfully!'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // User Profile Header
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 56,
                      backgroundColor: AppColors.primary,
                      child: Text('AD', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Alex Doe', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const Text('Professional UI/UX Freelancer', style: TextStyle(color: AppColors.textDim)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('PREMIUM PLAN', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Business Info Section
          _buildSettingsGroup(context, 'BUSINESS CONFIGURATION', [
            const ListTile(
              leading: Icon(Icons.monetization_on_outlined, color: AppColors.primary),
              title: Text('Default Hourly Rate', style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: SizedBox(
                width: 70,
                child: TextField(
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                  decoration: InputDecoration(
                    hintText: '\$50',
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _upiController,
                    decoration: const InputDecoration(
                      labelText: 'UPI ID',
                      prefixIcon: Icon(Icons.alternate_email, size: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _accountController,
                    decoration: const InputDecoration(
                      labelText: 'Bank Account/Card',
                      prefixIcon: Icon(Icons.account_balance, size: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _savePaymentInfo,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: AppColors.primary.withAlpha(50),
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                    ),
                    child: const Text('Save Payment Info'),
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 32),

          // Automation Settings
          _buildSettingsGroup(context, 'AUTOMATION & ASSISTANT', [
            SwitchListTile(
              title: const Text('Auto-send Invoices', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text('Automatically generate and email invoices when milestones are hit.', style: TextStyle(fontSize: 11)),
              value: _autoSendInvoices,
              onChanged: (val) => setState(() => _autoSendInvoices = val),
              secondary: const Icon(Icons.auto_fix_high, color: AppColors.accent),
              activeColor: AppColors.primary,
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('WhatsApp Reminders', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text('Send automated WhatsApp reminders for late payments.', style: TextStyle(fontSize: 11)),
              value: _whatsappReminders,
              onChanged: (val) => setState(() => _whatsappReminders = val),
              secondary: const Icon(Icons.chat_outlined, color: AppColors.secondary),
              activeColor: AppColors.primary,
            ),
          ]),

          const SizedBox(height: 48),

          // Logout Button
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: const Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              side: const BorderSide(color: AppColors.error, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );

    if (widget.isFullPage) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile Settings')),
        body: body,
      );
    }
    return body;
  }

  Widget _buildSettingsGroup(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
          child: Text(title, style: const TextStyle(color: AppColors.textDim, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(28),
            boxShadow: Theme.of(context).brightness == Brightness.light 
              ? [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15)] : [],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
