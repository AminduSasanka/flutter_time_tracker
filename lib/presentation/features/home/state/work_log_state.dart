import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogState {
  final WorkLog workLog;
  final bool isTimerRunning;

  WorkLogState(this.workLog, this.isTimerRunning);

  factory WorkLogState.initial() {
    return WorkLogState(
      WorkLog(taskKey: "", summary: "", description: ""),
      false,
    );
  }

  WorkLogState copyWith(WorkLog? workLog, bool? isTimerRunning) {
    return WorkLogState(
      workLog ?? this.workLog,
      isTimerRunning ?? this.isTimerRunning,
    );
  }
}
