import 'package:flutter/material.dart';
import '../models/daily_entry.dart';

/// A clean, custom calendar view widget
class CalendarView extends StatefulWidget {
  final List<DailyEntry> entries;
  final DateTime startDate;
  final int durationDays;
  final int totalTasks;

  const CalendarView({
    super.key,
    required this.entries,
    required this.startDate,
    required this.durationDays,
    required this.totalTasks,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _displayMonth;

  @override
  void initState() {
    super.initState();
    _displayMonth = DateTime(widget.startDate.year, widget.startDate.month);
  }

  void _previousMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calendar View',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              _buildWeekdayLabels(),
              _buildDaysGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final monthName = _getMonthName(_displayMonth.month);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: _previousMonth,
          ),
          Text(
            '$monthName ${_displayMonth.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: _nextMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayLabels() {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: weekdays.map((day) {
          return Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDaysGrid() {
    final firstDayOfMonth = DateTime(_displayMonth.year, _displayMonth.month, 1);
    final lastDayOfMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7; // Convert to 0-6 (Sunday-Saturday)
    final daysInMonth = lastDayOfMonth.day;

    final weeks = <Widget>[];
    var currentWeek = <Widget>[];

    // Add empty cells for days before the first day of the month
    for (var i = 0; i < firstWeekday; i++) {
      currentWeek.add(_buildEmptyDay());
    }

    // Add days of the month
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_displayMonth.year, _displayMonth.month, day);
      currentWeek.add(_buildDay(date));

      if (currentWeek.length == 7) {
        weeks.add(Row(children: currentWeek));
        currentWeek = <Widget>[];
      }
    }

    // Add empty cells for days after the last day of the month
    while (currentWeek.length < 7) {
      currentWeek.add(_buildEmptyDay());
    }
    if (currentWeek.isNotEmpty) {
      weeks.add(Row(children: currentWeek));
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: weeks),
    );
  }

  Widget _buildEmptyDay() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(4),
        ),
      ),
    );
  }

  Widget _buildDay(DateTime date) {
    final now = DateTime.now();
    final isToday = _isSameDay(date, now);
    final isInFuture = date.isAfter(now);
    
    // Check if this day is within the program duration
    final daysSinceStart = date.difference(widget.startDate).inDays;
    final isInProgram = daysSinceStart >= 0 && daysSinceStart < widget.durationDays;
    
    // Find entry for this day
    final entry = widget.entries.firstWhere(
      (e) => _isSameDay(e.date, date),
      orElse: () => DailyEntry(
        id: '',
        programId: '',
        dayIndex: daysSinceStart,
        date: date,
        completedTaskIds: [],
      ),
    );

    Color? backgroundColor;
    Color? borderColor;
    
    if (isInProgram && !isInFuture) {
      if (entry.id.isNotEmpty) {
        // Has entry - show completion status
        final completedTasks = entry.completedTaskIds.length;
        final percentage = widget.totalTasks > 0 ? completedTasks / widget.totalTasks : 0.0;
        
        if (percentage == 1.0) {
          backgroundColor = const Color(0xFF39d353).withOpacity(0.3);
          borderColor = const Color(0xFF39d353);
        } else if (percentage > 0) {
          backgroundColor = Colors.orange.withOpacity(0.3);
          borderColor = Colors.orange;
        } else {
          backgroundColor = Colors.red.withOpacity(0.3);
          borderColor = Colors.red;
        }
      } else {
        // In program but no entry
        backgroundColor = Colors.red.withOpacity(0.2);
        borderColor = Colors.red.withOpacity(0.5);
      }
    }

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(isToday ? 0.5 : 0.1),
              width: isToday ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: isInFuture
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white.withOpacity(0.9),
                fontSize: 14,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
