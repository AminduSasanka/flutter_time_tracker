import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/services/i_work_log_service.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/work_log_state.dart';

class WorkLogController extends AutoDisposeAsyncNotifier<WorkLogState> {
  final IWorkLogService _workLogService;

  WorkLogController(this._workLogService);

  @override
  Future<WorkLogState> build() async {
    final currentWorkLogResult = _workLogService.getCurrentWorkLog();
    WorkLog workLog = WorkLog(taskKey: "", summary: "", description: "");

    if (currentWorkLogResult.isSuccess()) {
      WorkLog? currentWorkLog = currentWorkLogResult.tryGetSuccess();

      if (currentWorkLog != null) {
        workLog = currentWorkLog;
      }
    }

    return WorkLogState(workLog);
  }
}
