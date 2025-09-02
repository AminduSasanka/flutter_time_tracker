import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/data/models/work_log_model.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/failures/work_log/work_log_not_found_failure.dart' show WorkLogNotFoundFailure;
import 'package:flutter_time_tracker/domain/repositories/i_work_log_repository.dart';
import 'package:flutter_time_tracker/domain/services/i_work_log_service.dart';
import 'package:multiple_result/multiple_result.dart';

class WorkLogService implements IWorkLogService {
  final IWorkLogRepository _workLogRepository;

  WorkLogService(this._workLogRepository);

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

    Duration spentTime = DateTime.now().difference(workLog.startTime!) ;
    int hours = spentTime.inHours;
    int minutes = spentTime.inMinutes.remainder(60);
    int seconds = spentTime.inSeconds.remainder(60);

    return "${hours}h ${minutes}m ${seconds}s";
  }
}
