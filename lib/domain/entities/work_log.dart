import 'package:flutter_time_tracker/core/constants/enums.dart';

class WorkLog {
  final String taskKey;
  final String summary;
  final String? description;
  final DateTime? startTime;
  final String? timeSpent;
  final WorkLogStateEnum workLogState;

  WorkLog({
    required this.taskKey,
    required this.summary,
    this.description,
    this.startTime,
    this.timeSpent,
    this.workLogState = WorkLogStateEnum.blank,
  });

  WorkLog copyWith({
    String? taskKey,
    String? summary,
    String? description,
    String? startTime,
    String? timeSpent,
    WorkLogStateEnum? workLogState,
  }) {
    return WorkLog(
      taskKey: taskKey ?? this.taskKey,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      startTime: startTime != null ? DateTime.parse(startTime) : this.startTime,
      timeSpent: timeSpent ?? this.timeSpent,
      workLogState: workLogState ?? this.workLogState,
    );
  }
}
