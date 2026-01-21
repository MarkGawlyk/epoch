import 'package:flutter/material.dart';
import '../models/daily_entry.dart';

/// A GitHub-style contribution heatmap widget
class GitHubContributionsView extends StatelessWidget {
  final List<DailyEntry> entries;
  final DateTime startDate;
  final int durationDays;

  const GitHubContributionsView({
    super.key,
    required this.entries,
    required this.startDate,
    required this.durationDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progress Heatmap',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildHeatmap(),
        const SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }

  Widget _buildHeatmap() {
    // Calculate weeks needed (7 days per week)
    final weeksNeeded = (durationDays / 7).ceil();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day labels
          Row(
            children: [
              const SizedBox(width: 24),
              ...['Mon', 'Wed', 'Fri'].map((day) => Container(
                width: 20,
                margin: const EdgeInsets.only(right: 4),
                child: Text(
                  day,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
              )),
            ],
          ),
          const SizedBox(height: 8),
          // Grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Week labels column
              Column(
                children: List.generate(
                  7,
                  (index) => Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(bottom: 4, right: 4),
                    child: index % 2 == 1
                        ? Text(
                            ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              // Days grid
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(weeksNeeded, (weekIndex) {
                      return Column(
                        children: List.generate(7, (dayIndex) {
                          final dayOffset = weekIndex * 7 + dayIndex;
                          return _buildDaySquare(dayOffset);
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDaySquare(int dayOffset) {
    final date = startDate.add(Duration(days: dayOffset));
    final now = DateTime.now();
    final isInFuture = date.isAfter(now);
    final isWithinProgram = dayOffset < durationDays;
    
    if (!isWithinProgram) {
      return Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(right: 4, bottom: 4),
      );
    }

    // Find entry for this day
    final entry = entries.firstWhere(
      (e) => _isSameDay(e.date, date),
      orElse: () => DailyEntry(
        id: '',
        programId: '',
        dayIndex: dayOffset,
        date: date,
        completedTaskIds: [],
      ),
    );

    Color color;
    if (isInFuture) {
      color = Colors.white.withOpacity(0.05);
    } else if (entry.id.isEmpty) {
      // No entry for this day
      color = Colors.white.withOpacity(0.1);
    } else {
      // Calculate completion percentage
      final totalTasks = 5; // This should come from the program
      final completedTasks = entry.completedTaskIds.length;
      final percentage = completedTasks / totalTasks;
      
      if (percentage == 1.0) {
        color = const Color(0xFF39d353); // GitHub green
      } else if (percentage >= 0.75) {
        color = const Color(0xFF26a641);
      } else if (percentage >= 0.5) {
        color = const Color(0xFF006d32);
      } else if (percentage >= 0.25) {
        color = const Color(0xFF0e4429);
      } else {
        color = Colors.red.withOpacity(0.3);
      }
    }

    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(right: 4, bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        Text(
          'Less',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        _buildLegendSquare(Colors.white.withOpacity(0.1)),
        _buildLegendSquare(const Color(0xFF0e4429)),
        _buildLegendSquare(const Color(0xFF006d32)),
        _buildLegendSquare(const Color(0xFF26a641)),
        _buildLegendSquare(const Color(0xFF39d353)),
        const SizedBox(width: 8),
        Text(
          'More',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendSquare(Color color) {
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
