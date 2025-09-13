import 'package:flutter_time_tracker/data/dto/jira_work_log/jira_work_log_response_dto.dart';
import 'package:flutter_time_tracker/data/sources/remote/jira/i_jira_api_service.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_work_log_sync_failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/failures/work_log/invalid_work_log_sync_failure.dart';
import 'package:flutter_time_tracker/domain/mappers/i_work_log_mapper.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_work_log_repository.dart';

class JiraWorkLogRepository implements IJiraWorkLogRepository {
  final IJiraApiService _jiraApiService;
  final IWorkLogMapper _mapper;

  JiraWorkLogRepository(this._jiraApiService, this._mapper);

  @override
  Future<JiraWorkLogResponseDto> createJiraWorkLog(WorkLog workLog) async {
    try {
      final jiraWorkLogCreateDto = _mapper.toJiraWorkLogCreateDto(workLog);
      final response = await _jiraApiService.post(
        "/issue/${workLog.taskKey}/worklog",
        jiraWorkLogCreateDto.toJson(),
      );

      if (response.isEmpty) {
        throw JiraWorkLogSyncFailure();
      }

      return JiraWorkLogResponseDto.fromJson(response);
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<bool> deleteJiraWorkLog(WorkLog workLog) async {
    try {
      if (workLog.jiraWorkLogId == null) return false;

      await _jiraApiService.delete(
        "/issue/${workLog.taskKey}/worklog/${workLog.jiraWorkLogId}",
      );

      return true;
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<JiraWorkLogResponseDto> getJiraWorkLog(WorkLog workLog) async {
    try {
      final response = await _jiraApiService.get(
        "/issue/${workLog.taskKey}/worklog",
        {},
      );

      if (response.isEmpty) {
        throw JiraWorkLogSyncFailure();
      }

      return JiraWorkLogResponseDto.fromJson(response);
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<JiraWorkLogResponseDto> updateJiraWorkLog(WorkLog workLog) async {
    try {
      if (workLog.jiraWorkLogId == null) {
        throw InvalidWorkLogSyncFailure(
          message: "Work log does not contain a Jira work log ID. Sync failed",
        );
      }

      final jiraWorkLogCreateDto = _mapper.toJiraWorkLogCreateDto(workLog);
      final response = await _jiraApiService.put(
        "/issue/${workLog.taskKey}/worklog/${workLog.jiraWorkLogId}",
        jiraWorkLogCreateDto.toJson(),
      );

      if (response.isEmpty) {
        throw JiraWorkLogSyncFailure();
      }

      return JiraWorkLogResponseDto.fromJson(response);
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }
}
