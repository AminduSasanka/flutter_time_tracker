import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IWorkLogService {
  Future<Result<void, Failure>> createWorkLog(WorkLog workLog);

  Future<Result<void, Failure>> deleteWorkLog(int id);

  Future<Result<void, Failure>> updateWorkLog(WorkLog workLog);

  Future<Result<WorkLog, Failure>> getCurrentWorkLog();

  Future<Result<void, Failure>> completeWorkLog();

  Future<Result<List<WorkLog>, Failure>> getCompletedWorkLogs();
}