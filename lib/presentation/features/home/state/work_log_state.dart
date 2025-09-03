import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogState {
  final WorkLog? workLog;
  final bool isTimerRunning;
  Duration elapsedTime = Duration.zero;

  WorkLogState(this.isTimerRunning, this.elapsedTime, [this.workLog]);

  factory WorkLogState.initial() {
    return WorkLogState(false, Duration.zero, null);
  }

  WorkLogState copyWith(WorkLog? workLog, bool? isTimerRunning, Duration? elapsedTime) {
    return WorkLogState(
      isTimerRunning ?? this.isTimerRunning,
      elapsedTime ?? this.elapsedTime,
      workLog ?? this.workLog,
    );
  }
}
