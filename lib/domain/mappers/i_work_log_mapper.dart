import 'package:flutter_time_tracker/data/dto/jira_work_log/jira_work_log_create_dto.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

abstract interface class IWorkLogMapper {
  JiraWorkLogCreateDto toJiraWorkLogCreateDto(WorkLog workLog);
}
