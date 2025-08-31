import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IJiraAuthService {
  Future<Result<void, Failure>> update(JiraAuth jiraAuth);

  Future<Result<void, Failure>> deleteApiToken();

  Future<Result<JiraAuth, Failure>> read();

  Future<Result<bool, Failure>> testConnection();
}