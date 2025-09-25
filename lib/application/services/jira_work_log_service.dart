import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/data/dto/jira_work_log/jira_work_log_response_dto.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/failures/work_log/invalid_work_log_sync_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_work_log_repository.dart';
import 'package:flutter_time_tracker/domain/repositories/i_work_log_repository.dart';
import 'package:flutter_time_tracker/domain/services/i_jira_work_log_service.dart';
import 'package:multiple_result/multiple_result.dart';

class JiraWorkLogService implements IJiraWorkLogService {
  final IJiraWorkLogRepository _jiraWorkLogRepository;
  final IWorkLogRepository _workLogRepository;

  JiraWorkLogService(this._jiraWorkLogRepository, this._workLogRepository);

  @override
  Future<Result<WorkLog, Failure>> syncWorkLog(WorkLog workLog) async {
    try {
      JiraWorkLogResponseDto responseDto;

      if (workLog.taskKey == "") {
        throw InvalidWorkLogSyncFailure(
          message: "Work log does not contain a task ID. Sync failed",
        );
      }

      if (workLog.jiraWorkLogId == null) {
        responseDto = await _jiraWorkLogRepository.createJiraWorkLog(workLog);
      } else {
        responseDto = await _jiraWorkLogRepository.updateJiraWorkLog(workLog);
      }

      WorkLog updatedWorkLog = workLog.copyWith(
        jiraWorkLogId: responseDto.id,
        workLogState: WorkLogStateEnum.synced,
      );

      await _workLogRepository.update(updatedWorkLog);

      return Result.success(updatedWorkLog);
    } catch (e, s) {
      if (e is Failure) {
        return Result.error(e);
      }

      return Result.error(
        UnknownFailure(
          exception: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Result<bool, Failure>> deleteWorkLog(WorkLog workLog) async {
    try {
      bool success = await _jiraWorkLogRepository.deleteJiraWorkLog(workLog);

      if (success && workLog.id != null) {
        await _workLogRepository.delete(workLog.id!);
      }

      return Result.success(success);
    } on Failure catch (e) {
      return Result.error(e);
    } catch (e, s) {
      return Result.error(
        UnknownFailure(
          exception: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Result<void, Failure>> bulkSyncWorkLogs(
    List<int> selectedWorkLogIds,
  ) async {
    try {
      List<WorkLog> worklogs = await _workLogRepository.getByIDList(
        selectedWorkLogIds,
      );

      for (WorkLog workLog in worklogs) {
        final result = await syncWorkLog(workLog);

        if (result.isError()) {
          throw result.tryGetError()!;
        }
      }

      return Result.success(null);
    } catch (e, s) {
      if (e is Failure) {
        return Result.error(e);
      }

      return Result.error(
        UnknownFailure(
          exception: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        ),
      );
    }
  }
}
