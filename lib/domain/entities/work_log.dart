import 'package:flutter_time_tracker/core/constants/enums.dart';

class WorkLog {
  final int? id;
  final String taskKey;
  final String summary;
  final String? description;
  final DateTime? startTime;
  final String? timeSpent;
  final WorkLogStateEnum workLogState;

  WorkLog({
    this.id,
    required this.taskKey,
    required this.summary,
    this.description,
    this.startTime,
    this.timeSpent,
    this.workLogState = WorkLogStateEnum.blank,
  });

  WorkLog copyWith({
    int? id,
    String? taskKey,
    String? summary,
    String? description,
    DateTime? startTime,
    String? timeSpent,
    WorkLogStateEnum? workLogState,
  }) {
    return WorkLog(
      id: id ?? this.id,
      taskKey: taskKey ?? this.taskKey,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      timeSpent: timeSpent ?? this.timeSpent,
      workLogState: workLogState ?? this.workLogState,
    );
  }
}
