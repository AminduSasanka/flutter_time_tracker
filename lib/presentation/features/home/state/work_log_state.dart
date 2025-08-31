import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogState {
  final WorkLog? workLog;
  final bool isTimerRunning;

  WorkLogState(this.isTimerRunning, [this.workLog]);

  factory WorkLogState.initial() {
    return WorkLogState(false, null);
  }

  WorkLogState copyWith(WorkLog? workLog, bool? isTimerRunning) {
    return WorkLogState(
      isTimerRunning ?? this.isTimerRunning,
      workLog ?? this.workLog,
    );
  }
}
