import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/state/add_worklog_screen_state.dart';

class AddWorklogScreenController
    extends AutoDisposeAsyncNotifier<AddWorklogScreenState> {
  @override
  FutureOr<AddWorklogScreenState> build() async {
    return AddWorklogScreenState(workLog: WorkLog.empty());
  }

  void addWorkLog({
    required String taskKey,
    required String summary,
    required String description,
    required String timeSpent,
    required String startDate,
  }) {
    final worklog = AsyncData(state.value!.workLog).value;

    state = AsyncLoading();

    ref
        .read(workLogServiceProvider)
        .createWorkLog(
          worklog.copyWith(
            taskKey: taskKey,
            summary: summary,
            description: description,
            timeSpent: timeSpent,
            startTime: DateTime.parse(startDate),
          ),
        );

    state = AsyncData(state.value!.copyWith(workLog: WorkLog.empty()));
  }
}
