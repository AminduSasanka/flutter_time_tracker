import 'dart:convert';

SearchJiraIssueResponseDto searchJiraIssueResponseDtoFromJson(String str) =>
    SearchJiraIssueResponseDto.fromJson(json.decode(str));

String searchJiraIssueResponseDtoToJson(SearchJiraIssueResponseDto data) =>
    json.encode(data.toJson());

class SearchJiraIssueResponseDto {
  final List<Section> sections;

  SearchJiraIssueResponseDto({required this.sections});

  SearchJiraIssueResponseDto copyWith({List<Section>? sections}) =>
      SearchJiraIssueResponseDto(sections: sections ?? this.sections);

  factory SearchJiraIssueResponseDto.fromJson(Map<String, dynamic> json) =>
      SearchJiraIssueResponseDto(
        sections: List<Section>.from(
          json["sections"].map((x) => Section.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
  };
}

class Section {
  final String id;
  final List<Issue> issues;
  final String label;
  final String msg;
  final String sub;

  Section({
    required this.id,
    required this.issues,
    required this.label,
    required this.msg,
    required this.sub,
  });

  Section copyWith({
    String? id,
    List<Issue>? issues,
    String? label,
    String? msg,
    String? sub,
  }) => Section(
    id: id ?? this.id,
    issues: issues ?? this.issues,
    label: label ?? this.label,
    msg: msg ?? this.msg,
    sub: sub ?? this.sub,
  );

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    issues: List<Issue>.from(json["issues"].map((x) => Issue.fromJson(x))),
    label: json["label"],
    msg: json["msg"],
    sub: json["sub"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "issues": List<dynamic>.from(issues.map((x) => x.toJson())),
    "label": label,
    "msg": msg,
    "sub": sub,
  };
}

class Issue {
  final int id;
  final String img;
  final String key;
  final String keyHtml;
  final String summary;
  final String summaryText;

  Issue({
    required this.id,
    required this.img,
    required this.key,
    required this.keyHtml,
    required this.summary,
    required this.summaryText,
  });

  Issue copyWith({
    int? id,
    String? img,
    String? key,
    String? keyHtml,
    String? summary,
    String? summaryText,
  }) => Issue(
    id: id ?? this.id,
    img: img ?? this.img,
    key: key ?? this.key,
    keyHtml: keyHtml ?? this.keyHtml,
    summary: summary ?? this.summary,
    summaryText: summaryText ?? this.summaryText,
  );

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
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
}
