import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class AddWorklogScreenState {
  WorkLog workLog;

  AddWorklogScreenState({required this.workLog});

  AddWorklogScreenState copyWith({required WorkLog workLog}) {
    return AddWorklogScreenState(workLog: workLog);
  }
}