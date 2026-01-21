/// Model for daily progress entry with optional photo
class DailyEntry {
  final String id;
  final String programId;
  final int dayIndex;
  final DateTime date;
  final List<String> completedTaskIds;
  final String? photoPath;
  final bool failed;

  DailyEntry({
    required this.id,
    required this.programId,
    required this.dayIndex,
    required this.date,
    required this.completedTaskIds,
    this.photoPath,
    this.failed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'programId': programId,
      'dayIndex': dayIndex,
      'date': date.toIso8601String(),
      'completedTaskIds': completedTaskIds,
      'photoPath': photoPath,
      'failed': failed,
    };
  }

  factory DailyEntry.fromJson(Map<String, dynamic> json) {
    return DailyEntry(
      id: json['id'],
      programId: json['programId'],
      dayIndex: json['dayIndex'],
      date: DateTime.parse(json['date']),
      completedTaskIds: List<String>.from(json['completedTaskIds']),
      photoPath: json['photoPath'],
      failed: json['failed'] ?? false,
    );
  }
}
