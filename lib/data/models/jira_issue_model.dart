import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';

class JIraIssueModel {
  final int id;
  final String img;
  final String key;
  final String keyHtml;
  final String summary;
  final String summaryText;

  JIraIssueModel({
    required this.id,
    required this.img,
    required this.key,
    required this.keyHtml,
    required this.summary,
    required this.summaryText,
  });

  JIraIssueModel copyWith({
    int? id,
    String? img,
    String? key,
    String? keyHtml,
    String? summary,
    String? summaryText,
  }) => JIraIssueModel(
    id: id ?? this.id,
    img: img ?? this.img,
    key: key ?? this.key,
    keyHtml: keyHtml ?? this.keyHtml,
    summary: summary ?? this.summary,
    summaryText: summaryText ?? this.summaryText,
  );

  factory JIraIssueModel.fromJson(Map<String, dynamic> json) => JIraIssueModel(
    id: json["id"],
    img: json["img"],
    key: json["key"],
    keyHtml: json["keyHtml"],
    summary: json["summary"],
    summaryText: json["summaryText"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
    "key": key,
    "keyHtml": keyHtml,
    "summary": summary,
    "summaryText": summaryText,
  };

  JIraIssue toEntity() {
    return JIraIssue(
      id: id,
      img: img,
      key: key,
      keyHtml: keyHtml,
      summary: summary,
      summaryText: summaryText,
    );
  }
}
