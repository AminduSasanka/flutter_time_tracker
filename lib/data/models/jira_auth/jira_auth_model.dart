import 'package:freezed_annotation/freezed_annotation.dart';

part 'jira_auth_model.freezed.dart';
part 'jira_auth_model.g.dart';

@Freezed()
class JiraAuthModel with _$JiraAuthModel {
  const factory JiraAuthModel({
    @JsonKey(name: 'apiToken') required String apiToken,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'workspace') required String workspace,
  }) = _JiraAuthModel;

  factory JiraAuthModel.fromJson(Map<String, dynamic> json) => _$JiraAuthModelFromJson(json);
}