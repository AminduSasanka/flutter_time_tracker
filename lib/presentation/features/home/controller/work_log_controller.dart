import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/work_log_state.dart';

class WorkLogController extends AutoDisposeAsyncNotifier<WorkLogState> {
  Timer? _timer;

  @override
  Future<WorkLogState> build() async {
    final currentWorkLogResult = await ref
        .read(workLogServiceProvider)
        .getCurrentWorkLog();

    if (currentWorkLogResult.isSuccess()) {
      WorkLog? currentWorkLog = currentWorkLogResult.tryGetSuccess();

      if (currentWorkLog != null) {
        Duration elapsedTime = currentWorkLog.startTime == null
            ? Duration.zero
            : DateTime.now().difference(currentWorkLog.startTime!);

        if (currentWorkLog.workLogState == WorkLogStateEnum.pending) {
          _startTimer();
        }

        return WorkLogState(
          currentWorkLog.workLogState == WorkLogStateEnum.pending,
          elapsedTime,
          currentWorkLog,
        );
      }
    }

    return WorkLogState(false, Duration.zero, null);
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
      startTime: DateTime.now(),
    );

    final result = await ref
        .read(workLogServiceProvider)
        .createWorkLog(workLog);

    if (result.isSuccess()) {
      state = AsyncData(
        WorkLogState(true, Duration.zero, result.tryGetSuccess()),
      );
      _startTimer();
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
      _stopTimer();
    }
  }

  Future<void> stopWorkLog() async {
    final result = await ref.read(workLogServiceProvider).completeWorkLog();

    if (result.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(WorkLog.empty(), false, Duration.zero),
      );
      _stopTimer();
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
      _stopTimer();
    }
  }

  Future<void> pauseWorkLog() async {
    if (state.value != null) {
      final result = await ref
          .read(workLogServiceProvider)
          .pauseWorkLog(state.value!.workLog!);

      if (result.isSuccess()) {
        state = AsyncData(
          state.value!.copyWith(
            state.value!.workLog,
            false,
            state.value!.elapsedTime,
          ),
        );
        _stopTimer();
      } else {
        state = AsyncError(result.tryGetError()!, StackTrace.current);
        _stopTimer();
      }
    }
  }

  Future<void> resumeWorkLog() async {
    if (state.value != null) {
      final result = await ref
          .read(workLogServiceProvider)
          .resumeWorkLog(state.value!.workLog!);

      if (result.isSuccess()) {
        state = AsyncData(
          state.value!.copyWith(
            state.value!.workLog,
            true,
            state.value!.elapsedTime,
          ),
        );
        _startTimer();
      } else {
        state = AsyncError(result.tryGetError()!, StackTrace.current);
        _stopTimer();
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      Duration elapsedTime = DateTime.now().difference(state.value!.workLog!.startTime!);

      state = AsyncValue.data(
        state.value!.copyWith(
          state.value!.workLog,
          true,
          elapsedTime,
        ),
      );
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
