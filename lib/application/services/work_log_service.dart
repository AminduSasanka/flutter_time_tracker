import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_work_log_repository.dart';
import 'package:flutter_time_tracker/domain/services/i_work_log_service.dart';
import 'package:multiple_result/multiple_result.dart';

class WorkLogService implements IWorkLogService {
  final IWorkLogRepository _workLogRepository;

  WorkLogService(this._workLogRepository);

  @override
  Result<void, Failure> createWorkLog(WorkLog workLog) {
    try {
      _workLogRepository.create(workLog);

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
  Result<void, Failure> deleteWorkLog() {
    try {
      _workLogRepository.delete();

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
  Result<WorkLog, Failure> getCurrentWorkLog() {
    try {
      final workLogModel = _workLogRepository.getCurrent();

      final workLog = WorkLog(
        taskKey: workLogModel.taskKey,
        summary: workLogModel.summary,
        description: workLogModel.description,
        timeSpent: workLogModel.timeSpent,
        workLogState: workLogModel.workLogState,
      );

      return Success(workLog);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Result<void, Failure> updateWorkLog(WorkLog workLog) {
    try {
      _workLogRepository.update(workLog);

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
  Result<void, Failure> completeWorkLog() {
    try {
      _workLogRepository.complete();

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
  Result<List<WorkLog>, Failure> getCompletedWorkLogs() {
    try {
      final workLogModels = _workLogRepository.getCompletedWorkLogs();
      final workLogs = workLogModels.map((e) => WorkLog(
        taskKey: e.taskKey,
        summary: e.summary,
        description: e.description,
        timeSpent: e.timeSpent,
        workLogState: e.workLogState,
      )).toList();

      return Success(workLogs);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }
}
