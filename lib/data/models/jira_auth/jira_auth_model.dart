// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'jira_auth_model.freezed.dart';
// part 'jira_auth_model.g.dart';
//
// @freezed
// class JiraAuthModel with _$JiraAuthModel {
//   factory JiraAuthModel({
//     @JsonKey(name: 'apiToken') required String apiToken,
//     @JsonKey(name: 'email') required String email,
//     @JsonKey(name: 'workspace') required String workspace,
//   }) = _JiraAuthModel;
//
//   factory JiraAuthModel.fromJson(Map<String, dynamic> json) => _$JiraAuthModelFromJson(json);
// }


class JiraAuthModel {
  final String apiToken;
  final String email;
  final String workspace;

  JiraAuthModel({required this.workspace, required this.email, required this.apiToken});

  factory JiraAuthModel.fromJson(Map<String, dynamic> json) {
    return JiraAuthModel(apiToken: json['apiToken'], email: json['email'], workspace: json['workspace']);
  }

  Map<String, dynamic> toJson() {
    return {
      "workspace": workspace,
      "email": email,
      "apiToken": apiToken
    };
  }
}