import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  bool _isTimerRunning = false;
  String _selectedProject = 'Design Phase';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time Tracker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Timer Card
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('02:45:12', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _selectedProject,
                    dropdownColor: AppColors.surface,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                    items: ['Design Phase', 'Frontend Dev', 'Meeting'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white70)),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedProject = val!),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => setState(() => _isTimerRunning = !_isTimerRunning),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isTimerRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                        color: AppColors.primary,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            
            // Today's Logs Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Logs", style: Theme.of(context).textTheme.titleLarge),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Manual Entry'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Logs List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final logs = [
                  {'title': 'Client Dashboard UI', 'project': 'Freelance Project A', 'time': '3h 30m'},
                  {'title': 'Bug Fixing', 'project': 'Internal Tool', 'time': '1h 15m'},
                  {'title': 'Sprint Meeting', 'project': 'Agency Work', 'time': '45m'},
                ];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    tileColor: AppColors.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text(logs[index]['title']!),
                    subtitle: Text(logs[index]['project']!, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                    trailing: Text(logs[index]['time']!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
