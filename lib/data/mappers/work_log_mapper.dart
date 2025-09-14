import 'package:flutter_time_tracker/data/dto/jira_work_log/jira_work_log_create_dto.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/mappers/i_work_log_mapper.dart';

class WorkLogMapper implements IWorkLogMapper {
  static const String _docType = "doc";
  static const String _textType = "text";
  static const String _paragraphType = "paragraph";
  static const int _defaultVersion = 1;

  WorkLogMapper();

  @override
  JiraWorkLogCreateDto toJiraWorkLogCreateDto(WorkLog workLog) {
    final comment = _buildComment(workLog);

    return JiraWorkLogCreateDto(
      comment: comment,
      started: _convertStartedTimeToString(workLog.startTime),
      timeSpent: workLog.timeSpent ?? "0h 0m",
    );
  }

  Comment _buildComment(WorkLog workLog) {
    final contentItems = <ContentContent>[];

    contentItems.add(ContentContent(text: workLog.summary, type: _textType));

    if (workLog.description?.isNotEmpty == true) {
      contentItems.add(
        ContentContent(text: ' - ${workLog.description!}', type: _textType),
      );
    }

    final commentContent = CommentContent(
      content: contentItems,
      type: _paragraphType,
    );

    return Comment(
      content: [commentContent],
      type: _docType,
      version: _defaultVersion,
    );
  }

  String _convertStartedTimeToString(DateTime? dateTime) {
    DateTime utcTime = dateTime == null ? DateTime.now() : dateTime.toUtc();

    return "${utcTime.year.toString().padLeft(4, '0')}-"
        "${utcTime.month.toString().padLeft(2, '0')}-"
        "${utcTime.day.toString().padLeft(2, '0')}T"
        "${utcTime.hour.toString().padLeft(2, '0')}:"
        "${utcTime.minute.toString().padLeft(2, '0')}:"
        "${utcTime.second.toString().padLeft(2, '0')}."
        "${utcTime.millisecond.toString().padLeft(3, '0')}+0000";
  }
}
