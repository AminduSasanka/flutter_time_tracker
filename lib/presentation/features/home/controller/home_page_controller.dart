import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/home_page_state.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/spent_time_to_duration.dart';

class HomePageController extends AsyncNotifier<HomePageState> {
  @override
  FutureOr<HomePageState> build() async {
    final todayResult = await ref
        .read(workLogServiceProvider)
        .getTodayWorkLogs();

    final weekResult = await ref
        .read(workLogServiceProvider)
        .getWeeklyWorkLogs();

    final monthResult = await ref
        .read(workLogServiceProvider)
        .getMonthlyWorkLogs();

    if (todayResult.isError() ||
        weekResult.isError() ||
        monthResult.isError()) {
      return HomePageState(
        todayHours: Duration.zero,
        todayTasksCount: 0,
        weekHours: Duration.zero,
        weekTasksCount: 0,
        monthHours: Duration.zero,
        monthTasksCount: 0,
        isError: true,
        errorMessage: todayResult.tryGetError()?.message ??
            weekResult.tryGetError()?.message ??
            monthResult.tryGetError()?.message ??
            "An unknown error occurred",
      );
    }

    final todayWorkLogs = todayResult.tryGetSuccess();
    final weekWorkLogs = weekResult.tryGetSuccess();
    final monthWorkLogs = monthResult.tryGetSuccess();

    if (todayWorkLogs!.isEmpty ||
        weekWorkLogs!.isEmpty ||
        monthWorkLogs!.isEmpty) {
      return HomePageState(
        todayHours: Duration.zero,
        todayTasksCount: 0,
        weekHours: Duration.zero,
        weekTasksCount: 0,
        monthHours: Duration.zero,
        monthTasksCount: 0,
        isError: false,
        errorMessage: "",
      );
    }

    return HomePageState(
      todayHours: _totalHours(todayWorkLogs),
      todayTasksCount: todayWorkLogs.length,
      weekHours: _totalHours(weekWorkLogs),
      weekTasksCount: weekWorkLogs.length,
      monthHours: _totalHours(monthWorkLogs),
      monthTasksCount: monthWorkLogs.length,
      isError: false,
      errorMessage: "",
    );
  }

  Duration _totalHours(List<WorkLog> workLogs) {
    Duration totalHours = Duration.zero;

    for (final workLog in workLogs) {
      if (workLog.timeSpent != null) {
        totalHours += spentTimeToDuration(workLog.timeSpent!);
      }
    }

    return totalHours;
  }
}
