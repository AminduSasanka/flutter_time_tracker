import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/state/history_screen_state.dart';

class HistoryScreenController
    extends AutoDisposeAsyncNotifier<HistoryScreenState> {
  @override
  Future<HistoryScreenState> build() async {
    List<WorkLog> workLogs = await _getWorkLogs();

    return HistoryScreenState(
      workLogs: workLogs,
      isError: false,
      errorMessage: null,
      filterStartDate: null,
      filterEndDate: null,
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

  Future<List<WorkLog>> _getWorkLogs({DateTime? startDate, DateTime? endDate}) async {
    final result = await ref
        .read(workLogServiceProvider)
        .getCompletedWorkLogs();

    if (result.isSuccess()) {
      List<WorkLog>? workLogs = result.tryGetSuccess();

      return workLogs!;
    }

    return [];
  }
}
