class JiraWorkLogResponseDto {
  Author? author;
  String? created;
  String? id;
  String? issueId;
  List<Property>? properties;
  String? self;
  String? started;
  String? timeSpent;
  int? timeSpentSeconds;
  Author? updateAuthor;
  String? updated;
  Visibility? visibility;

  JiraWorkLogResponseDto({
    this.author,
    this.created,
    this.id,
    this.issueId,
    this.properties,
    this.self,
    this.started,
    this.timeSpent,
    this.timeSpentSeconds,
    this.updateAuthor,
    this.updated,
    this.visibility,
  });

  factory JiraWorkLogResponseDto.fromJson(Map<String, dynamic> json) =>
      JiraWorkLogResponseDto(
        author: json["author"] != null ? Author.fromJson(json["author"]) : null,
        created: json["created"],
        id: json["id"],
        issueId: json["issueId"],
        properties: json["properties"] != null
            ? List<Property>.from(json["properties"].map((x) => Property.fromJson(x)))
            : null,
        self: json["self"],
        started: json["started"],
        timeSpent: json["timeSpent"],
        timeSpentSeconds: json["timeSpentSeconds"],
        updateAuthor: json["updateAuthor"] != null ? Author.fromJson(json["updateAuthor"]) : null,
        updated: json["updated"],
        visibility: json["visibility"] != null ? Visibility.fromJson(json["visibility"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "author": author?.toJson(),
    "created": created,
    "id": id,
    "issueId": issueId,
    "properties": properties != null ? List<dynamic>.from(properties!.map((x) => x.toJson())) : null,
    "self": self,
    "started": started,
    "timeSpent": timeSpent,
    "timeSpentSeconds": timeSpentSeconds,
    "updateAuthor": updateAuthor?.toJson(),
    "updated": updated,
    "visibility": visibility?.toJson(),
  };
}

class Author {
  String? accountId;
  String? accountType;
  bool? active;
  AvatarUrls? avatarUrls;
  String? displayName;
  String? emailAddress;
  String? key;
  String? name;
  String? self;
  String? timeZone;

  Author({
    this.accountId,
    this.accountType,
    this.active,
    this.avatarUrls,
    this.displayName,
    this.emailAddress,
    this.key,
    this.name,
    this.self,
    this.timeZone,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    accountId: json["accountId"],
    accountType: json["accountType"],
    active: json["active"],
    avatarUrls: json["avatarUrls"] != null ? AvatarUrls.fromJson(json["avatarUrls"]) : null,
    displayName: json["displayName"],
    emailAddress: json["emailAddress"],
    key: json["key"],
    name: json["name"],
    self: json["self"],
    timeZone: json["timeZone"],
  );

  Map<String, dynamic> toJson() => {
    "accountId": accountId,
    "accountType": accountType,
    "active": active,
    "avatarUrls": avatarUrls?.toJson(),
    "displayName": displayName,
    "emailAddress": emailAddress,
    "key": key,
    "name": name,
    "self": self,
    "timeZone": timeZone,
  };
}

class AvatarUrls {
  String? the16X16;
  String? the24X24;
  String? the32X32;
  String? the48X48;

  AvatarUrls({
    this.the16X16,
    this.the24X24,
    this.the32X32,
    this.the48X48,
  });

  factory AvatarUrls.fromJson(Map<String, dynamic> json) => AvatarUrls(
    the16X16: json["16x16"],
    the24X24: json["24x24"],
    the32X32: json["32x32"],
    the48X48: json["48x48"],
  );

  Map<String, dynamic> toJson() => {
    "16x16": the16X16,
    "24x24": the24X24,
    "32x32": the32X32,
    "48x48": the48X48,
  };
}

class Property {
  String? key;

  Property({this.key});

  factory Property.fromJson(Map<String, dynamic> json) =>
      Property(key: json["key"]);

  Map<String, dynamic> toJson() => {"key": key};
}

class Visibility {
  String? identifier;
  String? type;
  String? value;

  Visibility({
    this.identifier,
    this.type,
    this.value,
  });

  factory Visibility.fromJson(Map<String, dynamic> json) => Visibility(
    identifier: json["identifier"],
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "type": type,
    "value": value,
  };
}