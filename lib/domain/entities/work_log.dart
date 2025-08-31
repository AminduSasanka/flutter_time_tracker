import 'package:flutter_time_tracker/core/constants/enums.dart';

class WorkLog {
  final String taskKey;
  final String summary;
  final String description;
  final String? timeSpent;
  final WorkLogStateEnum workLogState;

  WorkLog({
    required this.taskKey,
    required this.summary,
    required this.description,
    this.timeSpent,
    this.workLogState = WorkLogStateEnum.blank,
  });

  WorkLog copyWith({
    String? taskKey,
    String? summary,
    String? description,
    String? timeSpent,
    WorkLogStateEnum? workLogState,
  }) {
    return WorkLog(
      taskKey: taskKey ?? this.taskKey,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      timeSpent: timeSpent ?? this.timeSpent,
      workLogState: workLogState ?? this.workLogState,
    );
  }
}
