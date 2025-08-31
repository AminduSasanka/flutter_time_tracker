import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_time_tracker/core/constants/jira_api_endpoints.dart';
import 'package:flutter_time_tracker/core/constants/secure_storage_keys.dart';
import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/i_secure_storage_service.dart';
import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_credentials_not_found_failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class JiraAuthRepository implements IJiraAuthRepository {
  final ISecureStorageService _secureStorageService;
  final Dio _dio;

  JiraAuthRepository(this._secureStorageService, this._dio);

  @override
  Future<void> delete() async {
    try {
      await _secureStorageService.delete(SecureStorageKeys.jiraAuthKey);
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
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
        throw JiraCredentialsNotFoundFailure();
      }
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> update(JiraAuth jiraAuth) async {
    try {
      JiraAuthModel jiraAuthModel = JiraAuthModel(
        apiToken: jiraAuth.apiToken,
        email: jiraAuth.email,
        workspace: jiraAuth.workspace,
      );
      String jsonString = jsonEncode(jiraAuthModel.toJson());

      await _secureStorageService.write(
        SecureStorageKeys.jiraAuthKey,
        jsonString,
      );
      await _createAndSaveJiraAccessToken(jiraAuth);
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<String> getAccessToken() async {
    try {
      String? accessToken = await _secureStorageService.read(
        SecureStorageKeys.jiraToken,
      );

      if (accessToken != null) {
        return accessToken;
      } else {
        throw Exception("Jira access token not found");
      }
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<bool> testConnection() async {
    try {
      _dio.options.baseUrl = "https://${(await read()).workspace}";
      _dio.options.headers = {
        "Authorization": "Basic ${await getAccessToken()}",
      };

      final response = await _dio.get(myselfEndpoint);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  Future<void> _createAndSaveJiraAccessToken(JiraAuth jiraAuth) async {
    try {
      String jiraTokenString = "${jiraAuth.email}:${jiraAuth.apiToken}";
      String base64String = base64Encode(utf8.encode(jiraTokenString));

      await _secureStorageService.write(
        SecureStorageKeys.jiraToken,
        base64String,
      );
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }
}
