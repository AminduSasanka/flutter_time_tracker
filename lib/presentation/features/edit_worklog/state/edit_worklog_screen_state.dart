import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class EditWorklogScreenState {
  WorkLog workLog;

  EditWorklogScreenState({required this.workLog});

  EditWorklogScreenState copyWith({required WorkLog workLog}) {
    return EditWorklogScreenState(workLog: workLog);
  }
}