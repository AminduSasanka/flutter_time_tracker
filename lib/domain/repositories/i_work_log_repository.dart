import 'package:flutter_time_tracker/data/models/work_log_model.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

abstract interface class IWorkLogRepository {
  Future<WorkLogModel> getCurrent();

  Future<WorkLogModel> getPausedWorkLog();

  Future<int> create(WorkLog workLog);

  Future<void> update(WorkLog workLog);

  Future<void> delete(int id);

  Future<List<WorkLogModel>> getCompletedWorkLogs();
}
