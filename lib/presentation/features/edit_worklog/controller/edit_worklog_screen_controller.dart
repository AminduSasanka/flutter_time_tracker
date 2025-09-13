import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/state/edit_worklog_screen_state.dart';
import 'package:multiple_result/multiple_result.dart';

class EditWorklogScreenController
    extends AutoDisposeFamilyAsyncNotifier<EditWorklogScreenState, int> {
  @override
  FutureOr<EditWorklogScreenState> build(int worklogId) async {
    final Result result = await ref
        .read(workLogServiceProvider)
        .getWorklogById(worklogId);

    if (result.isSuccess()) {
      return EditWorklogScreenState(workLog: result.tryGetSuccess());
    }

    return EditWorklogScreenState(workLog: WorkLog.empty());
  }

  Future<bool> saveWorkLog({
    required String taskKey,
    required String summary,
    required String description,
    required String timeSpent,
    required String startTime,
  }) async {
    final worklog = AsyncData(state.value!.workLog).value;

    state = AsyncLoading();

    final updatedWorkLog = worklog.copyWith(
      taskKey: taskKey,
      summary: summary,
      description: description,
      timeSpent: timeSpent,
      startTime: DateTime.parse(startTime),
    );

    final result = await ref
        .read(workLogServiceProvider)
        .updateWorkLog(updatedWorkLog);

    if (result.isSuccess()) {
      state = AsyncData(state.value!.copyWith(workLog: updatedWorkLog));

      return true;
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);

      return false;
    }
  }

  Future<bool> deleteWorkLog() async {
    final worklog = AsyncData(state.value!.workLog).value;

    state = AsyncLoading();

    final result = await ref
        .read(workLogServiceProvider)
        .deleteWorkLog(worklog.id!);

    if (result.isSuccess()) {
      state = AsyncData(state.value!.copyWith(workLog: WorkLog.empty()));

      return true;
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);

      return false;
    }
  }

  Future<bool> syncWorkLog() async {
    final worklog = AsyncData(state.value!.workLog).value;

    state = AsyncLoading();

    final result = await ref
        .read(jiraWorkLogServiceProvider)
        .syncWorkLog(worklog);

    if (result.isSuccess()) {
      if (result.tryGetSuccess() != null) {
        state = AsyncData(
          state.value!.copyWith(workLog: result.tryGetSuccess()!),
        );

        return true;
      } else {
        state = AsyncData(state.value!.copyWith(workLog: worklog));

        return false;
      }
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);

      return false;
    }
  }
}
