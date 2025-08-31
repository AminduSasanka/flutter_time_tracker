import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IWorkLogService {
  Result<void, Failure> createWorkLog (WorkLog workLog);

  Result<void, Failure> deleteWorkLog();

  Result<void, Failure> updateWorkLog(WorkLog workLog);

  Result<WorkLog?, Failure> getCurrentWorkLog();

  Result<void, Failure> completeWorkLog();

  Result<List<WorkLog>, Failure> getCompletedWorkLogs();
}