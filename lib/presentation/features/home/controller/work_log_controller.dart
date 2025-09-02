import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/work_log_state.dart';

class WorkLogController extends AutoDisposeAsyncNotifier<WorkLogState> {
  @override
  Future<WorkLogState> build() async {
    final currentWorkLogResult = await ref
        .read(workLogServiceProvider)
        .getCurrentWorkLog();

    if (currentWorkLogResult.isSuccess()) {
      WorkLog? currentWorkLog = currentWorkLogResult.tryGetSuccess();

      if (currentWorkLog != null) {
        return WorkLogState(
          currentWorkLog.workLogState == WorkLogStateEnum.pending,
          currentWorkLog,
        );
      }
    }

    return WorkLogState(false, null);
  }

  Future<void> startNewWorkLog(
    String taskId,
    String summary,
    String description,
  ) async {
    state = const AsyncLoading();

    final workLog = WorkLog(
      taskKey: taskId,
      summary: summary,
      description: description,
      workLogState: WorkLogStateEnum.pending,
    );

    final result = await ref
        .read(workLogServiceProvider)
        .createWorkLog(workLog);

    if (result.isSuccess()) {
      state = AsyncData(WorkLogState(true, workLog));
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
    }
  }

  Future<void> stopWorkLog() async {
    final result = await ref.read(workLogServiceProvider).completeWorkLog();

    if (result.isSuccess()) {
      state = AsyncData(state.value!.copyWith(WorkLog.empty(), false));
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
    }
  }

  Future<void> pauseWorkLog() async {
    if (state.value != null) {
      final result = await ref
          .read(workLogServiceProvider)
          .pauseWorkLog(state.value!.workLog!);

      if (result.isSuccess()) {
        state = AsyncData(state.value!.copyWith(state.value!.workLog, false));
      } else {
        state = AsyncError(result.tryGetError()!, StackTrace.current);
      }
    }
  }

  Future<void> resumeWorkLog() async {
    if (state.value != null) {
      final result = await ref
          .read(workLogServiceProvider)
          .resumeWorkLog(state.value!.workLog!);

      if (result.isSuccess()) {
        state = AsyncData(state.value!.copyWith(state.value!.workLog, true));
      } else {
        state = AsyncError(result.tryGetError()!, StackTrace.current);
      }
    }
  }
}
