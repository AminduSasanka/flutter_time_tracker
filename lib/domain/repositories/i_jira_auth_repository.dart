import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';

abstract interface class IJiraAuthRepository {
  Future<JiraAuthModel> read();

  Future<void> update(JiraAuth jiraAuth);

  Future<void> delete();

  Future<String> getAccessToken();
}