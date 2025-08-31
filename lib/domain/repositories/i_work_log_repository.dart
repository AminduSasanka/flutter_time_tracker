import 'package:flutter_time_tracker/data/models/work_log_model.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

abstract interface class IWorkLogRepository {
  WorkLogModel getCurrent();

  void create(WorkLog workLog);

  void update(WorkLog workLog);

  void delete();

  void complete();

  List<WorkLogModel> getCompletedWorkLogs();
}
