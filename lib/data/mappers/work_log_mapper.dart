import 'package:flutter_time_tracker/data/dto/jira_work_log/jira_work_log_create_dto.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogMapper {
  static const String _docType = "doc";
  static const String _textType = "text";
  static const int _defaultVersion = 1;

  static JiraWorkLogCreateDto toJiraWorkLogCreateDto(WorkLog workLog) {
    final comment = _buildComment(workLog);

    return JiraWorkLogCreateDto(
      comment: comment,
      started:
          workLog.startTime?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      timeSpent: workLog.timeSpent ?? "0m",
    );
  }

  static Comment _buildComment(WorkLog workLog) {
    final contentItems = <ContentContent>[];

    contentItems.add(ContentContent(text: workLog.summary, type: _textType));

    if (workLog.description?.isNotEmpty == true) {
      contentItems.add(
        ContentContent(text: workLog.description!, type: _textType),
      );
    }

    final commentContent = CommentContent(
      content: contentItems,
      type: _docType,
    );

    return Comment(
      content: [commentContent],
      type: _docType,
      version: _defaultVersion,
    );
  }
}
