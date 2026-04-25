import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  Timer? _timer;
  
  // App State: Current Active Tracker
  String _currentProject = 'Freelance Project A';
  String _currentPhase = 'Design Phase';
  
  // Storage for different project/phase durations
  final Map<String, Duration> _projectDurations = {
    'Freelance Project A - Design Phase': const Duration(hours: 2, minutes: 45, seconds: 12),
    'Freelance Project A - Meeting': Duration.zero,
    'Internal Tool - Bug Fixing': const Duration(hours: 1, minutes: 15),
    'Agency Work - Sprint Meeting': const Duration(minutes: 45),
  };

  final List<Map<String, String>> _logs = [
    {'title': 'Client Dashboard UI', 'project': 'Freelance Project A', 'time': '3h 30m'},
    {'title': 'Bug Fixing', 'project': 'Internal Tool', 'time': '1h 15m'},
    {'title': 'Sprint Meeting', 'project': 'Agency Work', 'time': '45m'},
  ];

  @override
  void initState() {
    super.initState();
    _startContinuousTimer();
  }

  void _startContinuousTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          final key = '$_currentProject - $_currentPhase';
          _projectDurations[key] = (_projectDurations[key] ?? Duration.zero) + const Duration(seconds: 1);
        });
      }
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  void _switchTracker(String project, String phase) {
    setState(() {
      _currentProject = project;
      _currentPhase = phase;
      final key = '$_currentProject - $_currentPhase';
      if (!_projectDurations.containsKey(key)) {
        _projectDurations[key] = Duration.zero;
      }
    });
  }

  void _showAddLogDialog() {
    final titleController = TextEditingController();
    final projectController = TextEditingController();
    final timeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 32, left: 24, right: 24),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add New Log', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(controller: titleController, decoration: const InputDecoration(hintText: 'Task Title (e.g. Code Review)')),
            const SizedBox(height: 16),
            TextField(controller: projectController, decoration: const InputDecoration(hintText: 'Project Name')),
            const SizedBox(height: 16),
            TextField(controller: timeController, decoration: const InputDecoration(hintText: 'Duration (e.g. 2h 30m)')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && projectController.text.isNotEmpty) {
                  setState(() {
                    _logs.insert(0, {
                      'title': titleController.text,
                      'project': projectController.text,
                      'time': timeController.text.isEmpty ? '0m' : timeController.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Log'),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  void _showAddPhaseDialog(String project) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 32, left: 24, right: 24),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add New Phase', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(controller: controller, decoration: const InputDecoration(hintText: 'Phase Name (e.g. Backend Dev)')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    final key = '$project - ${controller.text}';
                    if (!_projectDurations.containsKey(key)) {
                      _projectDurations[key] = Duration.zero;
                    }
                  });
                  Navigator.pop(context);
                  _switchTracker(project, controller.text);
                }
              },
              child: const Text('Add Phase'),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  void _showPhaseOptions(String project) {
    // Get unique phases for this project from our durations map
    List<String> projectPhases = _projectDurations.keys
        .where((key) => key.startsWith('$project - '))
        .map((key) => key.replaceFirst('$project - ', ''))
        .toList();
    
    // Ensure default phases exist if none are found
    if (projectPhases.isEmpty) {
      projectPhases = ['Meeting', 'Frontend', 'Design Phase'];
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Project: $project', style: const TextStyle(fontSize: 16, color: AppColors.textDim)),
            const SizedBox(height: 8),
            const Text('Select Phase', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...projectPhases.map((p) => _phaseTile(project, p)).toList(),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.add_circle_outline, color: AppColors.primary),
              title: const Text('Add New Phase', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                _showAddPhaseDialog(project);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _phaseTile(String project, String phase) {
    final isActive = _currentProject == project && _currentPhase == phase;
    return ListTile(
      title: Text(phase, style: TextStyle(fontWeight: isActive ? FontWeight.bold : null, color: isActive ? AppColors.primary : null)),
      trailing: isActive ? const Icon(Icons.check_circle, color: AppColors.primary) : const Icon(Icons.chevron_right),
      onTap: () {
        _switchTracker(project, phase);
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeKey = '$_currentProject - $_currentPhase';
    final activeDuration = _projectDurations[activeKey] ?? Duration.zero;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Time Tracker'), 
        backgroundColor: Colors.transparent, 
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Timer Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4361EE), Color(0xFF7209B7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4361EE).withOpacity(0.35),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _currentProject.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7), 
                      fontSize: 12, 
                      fontWeight: FontWeight.bold, 
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatDuration(activeDuration),
                        style: const TextStyle(
                          fontSize: 64, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _showPhaseOptions(_currentProject),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentPhase, 
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Today's Logs Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Today's Logs", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: _showAddLogDialog,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Log'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Logs List
            ..._logs.map((log) => _buildLogItem(log)).toList(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(Map<String, String> log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          setState(() => _currentProject = log['project']!);
          _showPhaseOptions(log['project']!);
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.timer, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(log['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(log['project']!, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                  ],
                ),
              ),
              Text(
                log['time']!, 
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
