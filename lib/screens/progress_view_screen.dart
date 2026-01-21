import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/program.dart';
import '../models/daily_entry.dart';
import '../widgets/github_contributions_view.dart';
import '../widgets/calendar_view.dart';

/// Screen displaying progress with GitHub-style heatmap and calendar views
class ProgressViewScreen extends StatefulWidget {
  final Program? program;
  final List<DailyEntry>? entries;

  const ProgressViewScreen({
    super.key,
    this.program,
    this.entries,
  });

  @override
  State<ProgressViewScreen> createState() => _ProgressViewScreenState();
}

class _ProgressViewScreenState extends State<ProgressViewScreen> {
  int _selectedView = 0; // 0 = Heatmap, 1 = Calendar

  @override
  Widget build(BuildContext context) {
    // Demo data if no program provided
    final program = widget.program ?? _getDemoProgram();
    final entries = widget.entries ?? _getDemoEntries(program);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Progress View',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a1a),
              Color(0xFF0a0a0a),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildStats(program, entries),
              const SizedBox(height: 32),
              _buildViewToggle(),
              const SizedBox(height: 24),
              if (_selectedView == 0)
                GitHubContributionsView(
                  entries: entries,
                  startDate: program.startDate,
                  durationDays: program.durationDays,
                  totalTasks: program.tasks.length,
                )
              else
                CalendarView(
                  entries: entries,
                  startDate: program.startDate,
                  durationDays: program.durationDays,
                  totalTasks: program.tasks.length,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats(Program program, List<DailyEntry> entries) {
    final totalDays = program.durationDays;
    final completedDays = entries.where((e) => e.completedTaskIds.isNotEmpty).length;
    final compliancePercentage = totalDays > 0 ? (completedDays / totalDays * 100).toInt() : 0;
    
    final currentDay = DateTime.now().difference(program.startDate).inDays + 1;
    final displayCurrentDay = currentDay.clamp(1, totalDays);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            program.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Current Day',
                  value: '$displayCurrentDay',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  label: 'Total Days',
                  value: '$totalDays',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Completed',
                  value: '$completedDays',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  label: 'Compliance',
                  value: '$compliancePercentage%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildViewToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              label: 'Heatmap',
              icon: Icons.grid_on,
              isSelected: _selectedView == 0,
              onTap: () => setState(() => _selectedView = 0),
            ),
          ),
          Expanded(
            child: _buildToggleButton(
              label: 'Calendar',
              icon: Icons.calendar_today,
              isSelected: _selectedView == 1,
              onTap: () => setState(() => _selectedView = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Demo data generators
  Program _getDemoProgram() {
    return Program(
      id: 'demo',
      name: 'Hard 75',
      durationDays: 75,
      tasks: [
        Task(id: '1', label: 'Exercise outdoors'),
        Task(id: '2', label: 'Exercise indoors'),
        Task(id: '3', label: 'Read 10 pages'),
        Task(id: '4', label: 'Drink water'),
        Task(id: '5', label: 'Take progress photo'),
      ],
      restartOnFail: true,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
    );
  }

  List<DailyEntry> _getDemoEntries(Program program) {
    final entries = <DailyEntry>[];
    
    for (var i = 0; i < 30; i++) {
      final date = program.startDate.add(Duration(days: i));
      final completedCount = (i % 5 == 0) ? 3 : 5; // Some days partially complete
      
      entries.add(DailyEntry(
        id: 'demo_$i',
        programId: program.id,
        dayIndex: i,
        date: date,
        completedTaskIds: program.tasks.take(completedCount).map((t) => t.id).toList(),
      ));
    }
    
    return entries;
  }
}
