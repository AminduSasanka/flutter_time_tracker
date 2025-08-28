import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class JiraAuthService {
  final IJiraAuthRepository _jiraAuthRepository;

  JiraAuthService(this._jiraAuthRepository);

  Future<void> saveApiToken(String token) async {
    try {
      await _jiraAuthRepository.saveToken(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteApiToken() async {
    try {
      await _jiraAuthRepository.deleteToken();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getApiToken() async {
    try {
      return await _jiraAuthRepository.getToken();
    } catch (e) {
      rethrow;
    }
  }
}
