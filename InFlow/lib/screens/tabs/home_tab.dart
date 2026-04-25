import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'InFlow',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.secondary,
              child: Text('AD', style: TextStyle(fontSize: 12, color: Colors.white)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metrics Section
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MetricCard(title: 'Total Earnings', value: '\$12,450', color: AppColors.primary),
                  MetricCard(title: 'Pending', value: '\$3,200', color: AppColors.secondary),
                  MetricCard(title: 'Overdue', value: '\$850', color: AppColors.error),
                  MetricCard(title: 'Hours worked', value: '142h', color: AppColors.accent),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Cash Flow Placeholder
            Text('Cash Flow', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    final height = [30, 50, 80, 40, 90, 60, 75][index];
                    return Container(
                      width: 24,
                      height: double.infinity * (height / 100),
                      margin: const EdgeInsets.only(bottom: 24, top: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Activity Feed
            Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final activities = [
                  {'icon': Icons.description, 'title': 'Invoice #204 generated', 'time': '2h ago'},
                  {'icon': Icons.email, 'title': 'Invoice sent to Client X', 'time': '4h ago'},
                  {'icon': Icons.chat, 'title': 'WhatsApp reminder sent', 'time': 'Yesterday'},
                  {'icon': Icons.payment, 'title': 'Payment received: \$2,400', 'time': 'Yesterday'},
                ];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(activities[index]['icon'] as IconData, color: AppColors.primary, size: 20),
                  ),
                  title: Text(activities[index]['title'] as String, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(activities[index]['time'] as String, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right, size: 16),
                  tileColor: AppColors.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                );
              },
            ),
            const SizedBox(height: 32),
            
            // Invoice Snapshot
            Text('Invoice Snapshot', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Client Alpha', style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('PAID', style: TextStyle(color: AppColors.success, fontSize: 8, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Text('\$1,200', style: Theme.of(context).textTheme.headlineSmall),
                        Text('12 May 2026', style: TextStyle(color: AppColors.textDim, fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
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

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.trending_up, color: color, size: 16),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
