import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogModel {
  final int? id;
  final String taskKey;
  final String summary;
  final String? description;
  final DateTime? startTime;
  final String? timeSpent;
  final WorkLogStateEnum workLogState;
  final String? jiraWorkLogId;

  WorkLogModel({
    this.id,
    required this.taskKey,
    required this.summary,
    this.description,
    this.startTime,
    this.timeSpent,
    this.workLogState = WorkLogStateEnum.blank,
    this.jiraWorkLogId,
  });

  factory WorkLogModel.fromJson(Map<String, dynamic> json) {
    return WorkLogModel(
      id: json['id'] as int?,
      taskKey: json['taskKey'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      timeSpent: json['timeSpent'] as String?,
      workLogState: WorkLogStateEnum.values.firstWhere(
        (state) => state.name == json['workLogState'],
      ),
      jiraWorkLogId: json['jiraWorkLogId'] as String?,
    );
  }

  factory WorkLogModel.fromMap(Map<String, dynamic> map) {
    return WorkLogModel(
      id: map['id'] as int?,
      taskKey: map['task_key'] as String,
      summary: map['summary'] as String,
      description: map['description'] as String?,
      startTime: map['start_time'] != null
          ? DateTime.parse(map['start_time'] as String)
          : null,
      timeSpent: map['time_spent'] as String?,
      workLogState: WorkLogStateEnum.values.firstWhere(
            (state) => state.name == map['work_log_state'],
      ),
      jiraWorkLogId: map['jira_work_log_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskKey': taskKey,
      'summary': summary,
      'description': description,
      'startTime': startTime?.toIso8601String(),
      'timeSpent': timeSpent,
      'workLogState': workLogState.name,
      'jiraWorkLogId': jiraWorkLogId,
    };
  }

  WorkLog toEntity() {
    return WorkLog(
      id: id,
      taskKey: taskKey,
      summary: summary,
      description: description,
      startTime: startTime,
      timeSpent: timeSpent,
      workLogState: workLogState,
      jiraWorkLogId: jiraWorkLogId,
    );
  }

  WorkLogModel copyWith({
    int? id,
    String? taskKey,
    String? summary,
    String? description,
    DateTime? startTime,
    String? timeSpent,
    WorkLogStateEnum? workLogState,
    String? jiraWorkLogId,
  }) {
    return WorkLogModel(
      id: id ?? this.id,
      taskKey: taskKey ?? this.taskKey,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      timeSpent: timeSpent ?? this.timeSpent,
      startTime: startTime ?? this.startTime,
      workLogState: workLogState ?? this.workLogState,
      jiraWorkLogId: jiraWorkLogId ?? this.jiraWorkLogId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_key': taskKey,
      'summary': summary,
      'description': description,
      'start_time': startTime?.toIso8601String(),
      'time_spent': timeSpent,
      'work_log_state': workLogState.name,
      'jira_work_log_id': jiraWorkLogId,
    };
  }
}
