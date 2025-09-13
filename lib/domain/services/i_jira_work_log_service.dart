import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IJiraWorkLogService {
  Future<Result<WorkLog, Failure>> syncWorkLog(WorkLog workLog);

  Future<Result<bool, Failure>> deleteWorkLog(WorkLog workLog);
}
