import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Suggestion Box
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.secondary.withOpacity(0.9), AppColors.primary.withOpacity(0.9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 5)),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 32),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "Client 'TechCorp' has been 5 days late on average. Recommended: Send reminders 2 days before due date.",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Text('Earnings Performance', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              height: 260,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(32),
                boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)],
              ),
              child: Column(
                children: [
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Monthly Revenue', style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: AppColors.success, size: 16),
                          SizedBox(width: 4),
                          Text('12% vs last month', style: TextStyle(color: AppColors.success, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Improved Graph Placeholder
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildGraphBar(0.4, 'Jan'),
                      _buildGraphBar(0.6, 'Feb'),
                      _buildGraphBar(0.5, 'Mar'),
                      _buildGraphBar(0.9, 'Apr', isHighlighted: true),
                      _buildGraphBar(0.7, 'May'),
                      _buildGraphBar(0.8, 'Jun'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Text('Performance Metrics', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildInsightCard(
                    context,
                    'Top Client',
                    'Design Studio',
                    Icons.star_rounded,
                    AppColors.accent,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildInsightCard(
                    context,
                    'Payment Speed',
                    '12 Days Avg.',
                    Icons.speed,
                    AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Text('Strategic Opportunities', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildOpportunityItem(
              context,
              'Low Profit Margin',
              'Internal Tool project is exceeding estimated time by 25%.',
              Icons.trending_down,
              AppColors.error,
            ),
            const SizedBox(height: 16),
            _buildOpportunityItem(
              context,
              'Upsell Opportunity',
              'Agency Work has consistent demand. Consider retainer model?',
              Icons.rocket_launch_outlined,
              AppColors.success,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphBar(double factor, String label, {bool isHighlighted = false}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 140 * factor,
          decoration: BoxDecoration(
            color: isHighlighted ? AppColors.primary : AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textDim)),
      ],
    );
  }

  Widget _buildInsightCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: color.withOpacity(0.1)),
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
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(color: AppColors.textDim, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOpportunityItem(BuildContext context, String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: AppColors.textDim, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
