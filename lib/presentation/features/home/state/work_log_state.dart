import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogState {
  final WorkLog workLog;

  WorkLogState(this.workLog);

  factory WorkLogState.initial() {
    return WorkLogState(WorkLog(taskKey: "", summary: "", description: ""));
  }

  WorkLogState copyWith(WorkLog? workLog) {
    return WorkLogState(workLog ?? this.workLog);
  }
}
