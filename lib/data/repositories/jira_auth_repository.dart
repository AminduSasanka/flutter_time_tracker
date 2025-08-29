import 'dart:convert';

import 'package:flutter_time_tracker/core/constants/secure_storage_keys.dart';
import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/i_secure_storage_service.dart';
import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class JiraAuthRepository implements IJiraAuthRepository {
  final ISecureStorageService _secureStorageService;

  JiraAuthRepository(this._secureStorageService);

  @override
  Future<void> delete() async {
    try {
      await _secureStorageService.delete(SecureStorageKeys.jiraAuthKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JiraAuthModel> read() async {
    try {
      String? jiraAuthJson = await _secureStorageService.read(
        SecureStorageKeys.jiraAuthKey,
      );

      if (jiraAuthJson != null) {
        return JiraAuthModel.fromJson(jsonDecode(jiraAuthJson));
      } else {
        throw Exception("Jira authentication info not found");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(JiraAuth jiraAuth) async {
    try {
      JiraAuthModel jiraAuthModel = JiraAuthModel(apiToken: jiraAuth.apiToken, email: jiraAuth.email, workspace: jiraAuth.workspace);
      String jsonString = jsonEncode(jiraAuthModel.toJson());

      await _secureStorageService.write(SecureStorageKeys.jiraAuthKey, jsonString);
      await _createAndSaveJiraAccessToken(jiraAuth);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getAccessToken() async {
    try {
      String? accessToken = await _secureStorageService.read(SecureStorageKeys.jiraToken);

      if (accessToken != null) {
        return accessToken;
      } else {
        throw Exception("Jira access token not found");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _createAndSaveJiraAccessToken(JiraAuth jiraAuth) async {
    try {
      String jiraTokenString = "${jiraAuth.email}:${jiraAuth.apiToken}";
      String base64String = base64Encode(utf8.encode(jiraTokenString));

      await _secureStorageService.write(SecureStorageKeys.jiraToken, base64String);
    } catch (e) {
      rethrow;
    }
  }
}
