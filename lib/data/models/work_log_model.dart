import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogModel {
  final String taskKey;
  final String summary;
  final String description;
  final String? timeSpent;
  final WorkLogStateEnum workLogState;

  WorkLogModel({
    required this.taskKey,
    required this.summary,
    required this.description,
    this.timeSpent,
    this.workLogState = WorkLogStateEnum.blank,
  });

  factory WorkLogModel.fromJson(Map<String, dynamic> json) {
    return WorkLogModel(
      taskKey: json['taskKey'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      timeSpent: json['timeSpent'] as String?,
      workLogState: WorkLogStateEnum.values.firstWhere(
        (state) => state.name == json['workLogState'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskKey': taskKey,
      'summary': summary,
      'description': description,
      'timeSpent': timeSpent,
      'workLogState': workLogState.name,
    };
  }

  WorkLog toEntity() {
    return WorkLog(
      taskKey: taskKey,
      summary: summary,
      description: description,
      timeSpent: timeSpent,
      workLogState: workLogState,
    );
  }
}
