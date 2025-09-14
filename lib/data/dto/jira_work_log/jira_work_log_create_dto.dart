class JiraWorkLogCreateDto {
  Comment comment;
  String started;
  String timeSpent;

  JiraWorkLogCreateDto({
    required this.comment,
    required this.started,
    required this.timeSpent,
  });

  factory JiraWorkLogCreateDto.fromJson(Map<String, dynamic> json) =>
      JiraWorkLogCreateDto(
        comment: Comment.fromJson(json["comment"]),
        started: json["started"],
        timeSpent: json["timeSpent"],
      );

  Map<String, dynamic> toJson() => {
    "comment": comment.toJson(),
    "started": started,
    "timeSpent": timeSpent,
  };
}

class Comment {
  List<CommentContent> content;
  String type;
  int version;

  Comment({required this.content, required this.type, required this.version});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    content: List<CommentContent>.from(
      json["content"].map((x) => CommentContent.fromJson(x)),
    ),
    type: json["type"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "type": type,
    "version": version,
  };
}

class CommentContent {
  List<ContentContent> content;
  String type;

  CommentContent({required this.content, required this.type});

  factory CommentContent.fromJson(Map<String, dynamic> json) => CommentContent(
    content: List<ContentContent>.from(
      json["content"].map((x) => ContentContent.fromJson(x)),
    ),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "type": type,
  };
}

class ContentContent {
  String text;
  String type;

  ContentContent({required this.text, required this.type});

  factory ContentContent.fromJson(Map<String, dynamic> json) =>
      ContentContent(text: json["text"], type: json["type"]);

  Map<String, dynamic> toJson() => {"text": text, "type": type};
}
