/// Model for a habit challenge program
class Program {
  final String id;
  final String name;
  final int durationDays;
  final List<Task> tasks;
  final bool restartOnFail;
  final DateTime startDate;

  Program({
    required this.id,
    required this.name,
    required this.durationDays,
    required this.tasks,
    required this.restartOnFail,
    required this.startDate,
  });

  DateTime get endDate => startDate.add(Duration(days: durationDays));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'durationDays': durationDays,
      'tasks': tasks.map((t) => t.toJson()).toList(),
      'restartOnFail': restartOnFail,
      'startDate': startDate.toIso8601String(),
    };
  }

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
      durationDays: json['durationDays'],
      tasks: (json['tasks'] as List).map((t) => Task.fromJson(t)).toList(),
      restartOnFail: json['restartOnFail'],
      startDate: DateTime.parse(json['startDate']),
    );
  }
}

/// Model for a task within a program
class Task {
  final String id;
  final String label;

  Task({
    required this.id,
    required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      label: json['label'],
    );
  }
}
