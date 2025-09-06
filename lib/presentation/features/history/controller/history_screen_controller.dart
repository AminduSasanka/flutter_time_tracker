import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/state/history_screen_state.dart';

class HistoryScreenController
    extends AutoDisposeAsyncNotifier<HistoryScreenState> {
  @override
  Future<HistoryScreenState> build() async {
    List<WorkLog> workLogs = await _getInitialWorkLogs(
      state: WorkLogStateEnum.completed,
    );

    return HistoryScreenState(
      workLogs: workLogs,
      isError: false,
      errorMessage: null
    );
  }

  Future<void> fetchWorkLogs() async {
    state = const AsyncLoading();

    final result = await ref
        .read(workLogServiceProvider)
        .getCompletedWorkLogs();

    if (result.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(
          workLogs: result.tryGetSuccess(),
          isError: false,
          errorMessage: null,
        ),
      );
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
    }
  }

  Future<void> deleteWorkLog(int id) async {
    try {
      state = const AsyncLoading();

      final result = await ref.read(workLogServiceProvider).deleteWorkLog(id);

      if (result.isSuccess()) {
        state = AsyncData(
          state.value!.copyWith(
            workLogs: await _getInitialWorkLogs(
              state: WorkLogStateEnum.completed,
            ),
            isError: false,
            errorMessage: null,
          ),
        );
      } else {
        state = AsyncError(result.tryGetError()!, StackTrace.current);
      }
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> filterWorkLogs({WorkLogStateEnum? worklogState, DateTime? startDate, String? taskKey}) async {
    state = const AsyncLoading();

    final result = await ref.read(workLogServiceProvider).getFilteredWorkLogs(
      state: worklogState,
      startDate: startDate,
      taskKey: taskKey
    );

    if (result.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(
          workLogs: result.tryGetSuccess(),
          isError: false,
          errorMessage: null,
          filterStartDate: startDate,
          filterTaskKey: taskKey,
          filterState: worklogState,
        ),
      );
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
    }
  }

  Future<List<WorkLog>> _getInitialWorkLogs({
    WorkLogStateEnum? state,
    DateTime? startDate,
    String? taskKey,
  }) async {
    final result = await ref
        .read(workLogServiceProvider)
        .getFilteredWorkLogs(
          state: state,
          startDate: startDate,
          taskKey: taskKey,
        );

    if (result.isSuccess()) {
      List<WorkLog>? workLogs = result.tryGetSuccess();

      return workLogs!;
    }

    return [];
  }
}
