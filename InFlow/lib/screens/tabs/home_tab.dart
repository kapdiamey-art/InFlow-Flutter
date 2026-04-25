import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';
import 'package:inflow/main.dart';
import 'package:inflow/screens/tabs/profile_tab.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = InFlowThemeManager.of(context);
    final isDark = themeManager?.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'InFlow',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Theme Toggle
          IconButton(
            onPressed: () {
              themeManager?.onThemeChanged(isDark ? ThemeMode.light : ThemeMode.dark);
            },
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                // In a real app, we might switch tabs, but for this demo, we'll push or use a global key.
                // For simplicity, we'll push the profile screen as a full page or toggle tab index.
                // The user asked to "navigate to Profile screen".
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileTab(isFullPage: true)));
              },
              borderRadius: BorderRadius.circular(20),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.secondary,
                child: Text('AD', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Finish Project'),
        icon: const Icon(Icons.check_circle_outline),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metrics Section (Larger Cards)
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  MetricCard(title: 'Total Earnings', value: '\$12,450', color: AppColors.primary, icon: Icons.payments_outlined),
                  MetricCard(title: 'Pending', value: '\$3,200', color: AppColors.secondary, icon: Icons.hourglass_empty),
                  MetricCard(title: 'Overdue', value: '\$850', color: AppColors.error, icon: Icons.warning_amber_rounded),
                  MetricCard(title: 'Hours worked', value: '142h', color: AppColors.accent, icon: Icons.timer_outlined),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Cash Flow
            Text('Cash Flow Performance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            Container(
              height: 220,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surface : Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  final heightFactor = [0.3, 0.5, 0.8, 0.4, 0.9, 0.6, 0.75][index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 28,
                        height: 140 * heightFactor,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][index], style: const TextStyle(fontSize: 10, color: AppColors.textDim)),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 40),
            
            // Recent Activity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final activities = [
                  {'icon': Icons.description_outlined, 'title': 'Invoice #204 generated', 'time': '2h ago', 'color': AppColors.primary},
                  {'icon': Icons.email_outlined, 'title': 'Invoice sent to TechCorp', 'time': '4h ago', 'color': AppColors.accent},
                  {'icon': Icons.chat_bubble_outline, 'title': 'WhatsApp reminder sent', 'time': 'Yesterday', 'color': AppColors.secondary},
                  {'icon': Icons.account_balance_wallet_outlined, 'title': 'Payment received: \$2,400', 'time': 'Yesterday', 'color': AppColors.success},
                ];
                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surface : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (activities[index]['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(activities[index]['icon'] as IconData, color: activities[index]['color'] as Color, size: 22),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activities[index]['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                              Text(activities[index]['time'] as String, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textDim),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 170, // Increased size
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(24), // Increased padding
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        boxShadow: isDark ? [] : [BoxShadow(color: color.withOpacity(0.1), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(color: AppColors.textDim, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Larger font
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final notifications = [
            {'title': 'Invoice #204 generated', 'desc': 'Auto-generated based on time logs', 'icon': Icons.description, 'time': '2h ago'},
            {'title': 'Payment Received', 'desc': 'Client TechCorp paid \$2,400', 'icon': Icons.check_circle, 'time': '5h ago'},
            {'title': 'Reminder Sent', 'desc': 'Reminder sent to Client Y', 'icon': Icons.notifications_active, 'time': 'Yesterday'},
            {'title': 'New Task Logged', 'desc': '3h recorded for Project A', 'icon': Icons.timer, 'time': '2 days ago'},
            {'title': 'System Update', 'desc': 'AI Insights have been refreshed', 'icon': Icons.auto_fix_high, 'time': '3 days ago'},
          ];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(notifications[index]['icon'] as IconData, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notifications[index]['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(notifications[index]['desc'] as String, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                    ],
                  ),
                ),
                Text(notifications[index]['time'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textDim)),
              ],
            ),
          );
        },
      ),
    );
  }
}
