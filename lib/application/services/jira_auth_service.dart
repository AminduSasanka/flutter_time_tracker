import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';
import 'package:flutter_time_tracker/domain/services/i_jira_auth_service.dart';
import 'package:multiple_result/multiple_result.dart';

class JiraAuthService implements IJiraAuthService {
  final IJiraAuthRepository _jiraAuthRepository;

  JiraAuthService(this._jiraAuthRepository);

  @override
  Future<Result<void, Failure>> update(JiraAuth jiraAuth) async {
    try {
      await _jiraAuthRepository.update(jiraAuth);

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<void, Failure>> deleteApiToken() async {
    try {
      await _jiraAuthRepository.delete();

      return Success(null);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<JiraAuth, Failure>> read() async {
    try {
      JiraAuthModel jiraAuthModel = await _jiraAuthRepository.read();
      JiraAuth jiraAuth = JiraAuth(
        jiraAuthModel.apiToken,
        jiraAuthModel.email,
        jiraAuthModel.workspace,
      );

      return Success(jiraAuth);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }

  @override
  Future<Result<bool, Failure>> testConnection() async {
    try {
      bool isConnected = await _jiraAuthRepository.testConnection();

      return Success(isConnected);
    } catch (e, s) {
      return Error(
        e is Failure
            ? e
            : UnknownFailure(exception: Exception(e.toString()), stackTrace: s),
      );
    }
  }
}
