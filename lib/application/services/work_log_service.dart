import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/data/models/work_log_model.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/failures/work_log/work_log_not_found_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_work_log_repository.dart';
import 'package:flutter_time_tracker/domain/repositories/i_work_log_repository.dart';
import 'package:flutter_time_tracker/domain/services/i_work_log_service.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/spent_time_to_duration.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

class WorkLogService implements IWorkLogService {
  final IWorkLogRepository _workLogRepository;
  final IJiraWorkLogRepository _jiraWorkLogRepository;

  WorkLogService(this._workLogRepository, this._jiraWorkLogRepository);

  @override
  Future<Result<WorkLog, Failure>> createWorkLog(WorkLog workLog) async {
    try {
      final id = await _workLogRepository.create(workLog);
      final createdWorkLog = workLog.copyWith(id: id);

      return Success(createdWorkLog);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> deleteWorkLog(int id) async {
    try {
      final workLogModel = await _workLogRepository.getByID(id);

      if (workLogModel.workLogState == WorkLogStateEnum.synced &&
          workLogModel.jiraWorkLogId != null) {
        await _jiraWorkLogRepository.deleteJiraWorkLog(workLogModel.toEntity());
      }

      await _workLogRepository.delete(id);

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<WorkLog, Failure>> getCurrentWorkLog() async {
    try {
      final workLogModel = await _workLogRepository.getCurrent();
      final workLog = workLogModel.toEntity();

      return Success(workLog);
    } on WorkLogNotFoundFailure {
      try {
        final workLogModel = await _workLogRepository.getPausedWorkLog();
        final workLog = workLogModel.toEntity();
        return Success(workLog);
      } on WorkLogNotFoundFailure catch (e) {
        return Error(e);
      }
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> updateWorkLog(WorkLog workLog) async {
    try {
      if (workLog.id == null) {
        throw WorkLogNotFoundFailure();
      }

      if (workLog.workLogState == WorkLogStateEnum.synced &&
          workLog.jiraWorkLogId != null) {
        await _jiraWorkLogRepository.updateJiraWorkLog(workLog);
      }

      await _workLogRepository.update(workLog);

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> completeWorkLog() async {
    try {
      final WorkLogModel currentWorkLog = await _workLogRepository.getCurrent();
      final WorkLogModel completedWorkLogModel = currentWorkLog.copyWith(
        workLogState: WorkLogStateEnum.completed,
        timeSpent: _getSpentTime(currentWorkLog.toEntity()),
      );

      await _workLogRepository.update(completedWorkLogModel.toEntity());

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<List<WorkLog>, Failure>> getCompletedWorkLogs() async {
    try {
      final workLogModels = await _workLogRepository.getCompletedWorkLogs();
      final workLogs = workLogModels.map((e) => e.toEntity()).toList();

      return Success(workLogs);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> pauseWorkLog(WorkLog workLog) async {
    try {
      if (workLog.id == null) {
        throw WorkLogNotFoundFailure();
      }

      final pausedWorkLog = workLog.copyWith(
        workLogState: WorkLogStateEnum.paused,
        timeSpent: _getSpentTime(workLog),
      );

      await _workLogRepository.update(pausedWorkLog);

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> resumeWorkLog(WorkLog workLog) async {
    try {
      if (workLog.id == null) {
        throw WorkLogNotFoundFailure();
      }

      final resumedWorkLog = workLog.copyWith(
        workLogState: WorkLogStateEnum.pending,
        startTime: DateTime.now(),
      );

      await _workLogRepository.update(resumedWorkLog);

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  String _getSpentTime(WorkLog workLog) {
    if (workLog.startTime == null) {
      return "";
    }

    Duration totalSpentTime = Duration.zero;

    if (workLog.timeSpent != null) {
      totalSpentTime = spentTimeToDuration(workLog.timeSpent!);
    }

    Duration spentTime = DateTime.now().difference(workLog.startTime!);
    totalSpentTime += spentTime;

    int hours = totalSpentTime.inHours;
    int minutes = totalSpentTime.inMinutes.remainder(60);
    int seconds = totalSpentTime.inSeconds.remainder(60);
    int additionalMinutes = (seconds / 60).round();
    minutes += additionalMinutes;

    return "${hours}h ${minutes}m";
  }

  @override
  Future<Result<Map<String, List<WorkLog>>, Failure>> getFilteredWorkLogs({
    List<WorkLogStateEnum>? states,
    String? taskKey,
    DateTime? startDate,
    int? page,
    int? pageSize,
  }) async {
    try {
      final workLogModels = await _workLogRepository.getFilteredWorkLogs(
        states: states,
        taskKey: taskKey,
        startDate: startDate,
        page: page ?? 1,
        pageSize: pageSize ?? 10,
      );

      final Map<String, List<WorkLog>> groupedWorkLogs = {};

      for (final workLogModel in workLogModels) {
        final dateKey = DateFormat(
          'yyyy-MM-dd',
        ).format(workLogModel.startTime!);

        groupedWorkLogs.putIfAbsent(dateKey, () => []);
        groupedWorkLogs[dateKey]!.add(workLogModel.toEntity());
      }

      return Success(groupedWorkLogs);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<WorkLog, Failure>> getWorklogById(int id) async {
    try {
      final WorkLogModel workLogModel = await _workLogRepository.getByID(id);

      return Success(workLogModel.toEntity());
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> bulkDeleteWorkLogs(List<int> ids) async {
    try {
      List<WorkLog> workLogs = await _workLogRepository.getByIDList(ids);
      final syncedWorkLogs = workLogs.where(
        (workLog) => workLog.workLogState == WorkLogStateEnum.synced,
      );

      for (final workLog in syncedWorkLogs) {
        await _jiraWorkLogRepository.deleteJiraWorkLog(workLog);
      }

      await _workLogRepository.bulkDeleteWorkLogs(ids);

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<List<WorkLog>, Failure>> getTodayWorkLogs() async {
    try {
      final workLogModels = await _workLogRepository.getWorkLogsByDates(
        DateTime.now(),
        DateTime.now(),
      );
      final workLogs = workLogModels.map((e) => e.toEntity()).toList();

      return Success(workLogs);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<List<WorkLog>, Failure>> getWeeklyWorkLogs() async {
    try {
      DateTime today = DateTime.now();
      Duration datesToMonday = Duration(days: today.weekday - 1);
      Duration datesToSunday = Duration(days: 7 - today.weekday);

      final workLogModels = await _workLogRepository.getWorkLogsByDates(
        DateTime.now().subtract(datesToMonday),
        DateTime.now().add(datesToSunday),
      );
      final workLogs = workLogModels.map((e) => e.toEntity()).toList();

      return Success(workLogs);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<List<WorkLog>, Failure>> getMonthlyWorkLogs() async {
    try {
      DateTime today = DateTime.now();
      DateTime monthStart = DateTime(today.year, today.month, 1);
      DateTime monthEnd = DateTime(today.year, today.month + 1, 0);

      final workLogModels = await _workLogRepository.getWorkLogsByDates(
        monthStart,
        monthEnd,
      );
      final workLogs = workLogModels.map((e) => e.toEntity()).toList();

      return Success(workLogs);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<WorkLog, Failure>> startWorkLogFrom(WorkLog workLog) async {
    try {
      WorkLog newWorklog = WorkLog(
        taskKey: workLog.taskKey,
        summary: workLog.summary,
        startTime: DateTime.now(),
        workLogState: WorkLogStateEnum.pending,
      );

      final id = await _workLogRepository.create(newWorklog);
      final createdWorkLog = workLog.copyWith(id: id);

      return Success(createdWorkLog);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }
}
