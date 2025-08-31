import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/work_log_state.dart';

class WorkLogController extends AutoDisposeNotifier<WorkLogState> {
  @override
  WorkLogState build() {
    final currentWorkLogResult = ref
        .read(workLogServiceProvider)
        .getCurrentWorkLog();
    WorkLog workLog = WorkLog(taskKey: "", summary: "", description: "");

    if (currentWorkLogResult.isSuccess()) {
      WorkLog? currentWorkLog = currentWorkLogResult.tryGetSuccess();

      if (currentWorkLog != null) {
        workLog = currentWorkLog;
      }
    }

    return WorkLogState(
      workLog,
      WorkLogStateEnum.pending == workLog.workLogState.name,
    );
  }
}
