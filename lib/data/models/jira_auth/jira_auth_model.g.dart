// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JiraAuthModel _$JiraAuthModelFromJson(Map<String, dynamic> json) =>
    _JiraAuthModel(
      apiToken: json['apiToken'] as String,
      email: json['email'] as String,
      workspace: json['workspace'] as String,
    );

Map<String, dynamic> _$JiraAuthModelToJson(_JiraAuthModel instance) =>
    <String, dynamic>{
      'apiToken': instance.apiToken,
      'email': instance.email,
      'workspace': instance.workspace,
    };
