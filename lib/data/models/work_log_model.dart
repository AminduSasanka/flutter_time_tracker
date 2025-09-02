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

  WorkLogModel({
    this.id,
    required this.taskKey,
    required this.summary,
    this.description,
    this.startTime,
    this.timeSpent,
    this.workLogState = WorkLogStateEnum.blank,
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
    );
  }

  WorkLogModel copyWith({
    String? taskKey,
    String? summary,
    String? description,
    DateTime? startTime,
    String? timeSpent,
    WorkLogStateEnum? workLogState,
  }) {
    return WorkLogModel(
      taskKey: taskKey ?? this.taskKey,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      timeSpent: timeSpent ?? this.timeSpent,
      startTime: startTime ?? this.startTime,
      workLogState: workLogState ?? this.workLogState,
    );
  }
}
