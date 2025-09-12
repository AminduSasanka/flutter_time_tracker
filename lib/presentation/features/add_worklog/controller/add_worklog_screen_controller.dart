import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/state/add_worklog_screen_state.dart';

class AddWorklogScreenController
    extends AutoDisposeNotifier<AddWorklogScreenState> {
  @override
  AddWorklogScreenState build() {
    return AddWorklogScreenState(workLog: WorkLog.empty());
  }

  Future<bool> addWorkLog({
    required String taskKey,
    required String summary,
    required String description,
    required String timeSpent,
    required String startDate,
  }) async {
    final worklog = state.workLog;

    final result = await ref
        .read(workLogServiceProvider)
        .createWorkLog(
          worklog.copyWith(
            taskKey: taskKey,
            summary: summary,
            description: description,
            timeSpent: timeSpent,
            startTime: DateTime.parse(startDate),
            workLogState: WorkLogStateEnum.completed,
          ),
        );

    if (result.isSuccess()) {
      state = state.copyWith(workLog: WorkLog.empty());

      return true;
    } else {
      return false;
    }
  }
}
