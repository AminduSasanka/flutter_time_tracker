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
}
