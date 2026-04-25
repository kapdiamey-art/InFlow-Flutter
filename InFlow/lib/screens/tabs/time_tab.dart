import 'dart:async';
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
  Duration _duration = const Duration(hours: 2, minutes: 45, seconds: 12);
  Timer? _timer;

  final List<Map<String, String>> _logs = [
    {'title': 'Client Dashboard UI', 'project': 'Freelance Project A', 'time': '3h 30m'},
    {'title': 'Bug Fixing', 'project': 'Internal Tool', 'time': '1h 15m'},
    {'title': 'Sprint Meeting', 'project': 'Agency Work', 'time': '45m'},
  ];

  void _startTimer() {
    setState(() => _isTimerRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    setState(() => _isTimerRunning = false);
    _timer?.cancel();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _showManualEntryForm() {
    final nameController = TextEditingController();
    final hoursController = TextEditingController();
    final notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24, left: 24, right: 24,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Manual Time Entry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Project / Task Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: hoursController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Hours (e.g. 1.5)'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Notes (optional)'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && hoursController.text.isNotEmpty) {
                    setState(() {
                      _logs.insert(0, {
                        'title': nameController.text,
                        'project': 'Manual Entry',
                        'time': '${hoursController.text}h',
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Time entry added!')),
                    );
                  }
                },
                child: const Text('Add Entry'),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                  Text(_formatDuration(_duration), 
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _selectedProject,
                    dropdownColor: AppColors.surface,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                    items: ['Design Phase', 'Frontend Dev', 'Meeting'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedProject = val!),
                  ),
                  const SizedBox(height: 32),
                  InkWell(
                    onTap: _isTimerRunning ? _stopTimer : _startTimer,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                        ],
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
                ElevatedButton.icon(
                  onPressed: _showManualEntryForm,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Log'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Logs List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: Theme.of(context).brightness == Brightness.light 
                        ? [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)] : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.access_time_filled, color: AppColors.primary, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_logs[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(_logs[index]['project']!, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                            ],
                          ),
                        ),
                        Text(_logs[index]['time']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.accent)),
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
