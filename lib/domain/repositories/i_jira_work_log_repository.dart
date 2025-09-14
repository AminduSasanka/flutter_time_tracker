import 'package:flutter_time_tracker/data/dto/jira_work_log/jira_work_log_response_dto.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

abstract interface class IJiraWorkLogRepository {
  Future<JiraWorkLogResponseDto> createJiraWorkLog(WorkLog workLog);

  Future<JiraWorkLogResponseDto> updateJiraWorkLog(WorkLog workLog);

  Future<bool> deleteJiraWorkLog(WorkLog workLog);

  Future<JiraWorkLogResponseDto> getJiraWorkLog(WorkLog workLog);
}