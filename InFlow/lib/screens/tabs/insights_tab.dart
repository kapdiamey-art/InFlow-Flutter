import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Insights')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Suggestion Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.secondary.withOpacity(0.8), AppColors.primary.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Client 'TechCorp' has been 5 days late on average. I'll send reminders earlier next month.",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Earnings Performance', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(Icons.show_chart, color: AppColors.primary.withOpacity(0.5), size: 100),
              ),
            ),
            const SizedBox(height: 32),

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
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInsightCard(
                    context,
                    'Avg. Payment',
                    '12 Days',
                    Icons.calendar_month,
                    AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Text('Opportunities', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildSuggestionItem(
              context,
              'Low Profit Margin',
              'Project B is taking 40% more time than estimated.',
              Icons.trending_down,
              AppColors.error,
            ),
            const SizedBox(height: 12),
            _buildSuggestionItem(
              context,
              'Payment Speed',
              'Startup X pays within 24 hours. Prioritize their work?',
              Icons.speed,
              AppColors.success,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(BuildContext context, String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
