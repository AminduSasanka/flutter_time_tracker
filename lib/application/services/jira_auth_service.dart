import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class JiraAuthService {
  final IJiraAuthRepository _jiraAuthRepository;

  JiraAuthService(this._jiraAuthRepository);

  Future<void> update(JiraAuth jiraAuth) async {
    try {
      await _jiraAuthRepository.update(jiraAuth);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteApiToken() async {
    try {
      await _jiraAuthRepository.delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<JiraAuth> read() async {
    try {
      JiraAuthModel jiraAuthModel = await _jiraAuthRepository.read();

      return JiraAuth(
        jiraAuthModel.apiToken,
        jiraAuthModel.email,
        jiraAuthModel.workspace,
      );
    } catch (e) {
      rethrow;
    }
  }
}
