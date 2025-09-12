import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/data/sources/remote/jira/i_jira_api_service.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_access_denied_failure.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_authentication_failure.dart';
import 'package:flutter_time_tracker/domain/failures/network_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class JiraApiService implements IJiraApiService {
  final Dio _dio;
  final IJiraAuthRepository _jiraAuthRepository;

  JiraApiService(this._dio, this._jiraAuthRepository);

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    final data = await _sendRequest(() async => await _dio.delete(url));

    return data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> get(
    String url,
    Map<String, dynamic>? queryParams,
  ) async {
    final data = await _sendRequest(
      () async => await _dio.get(url, queryParameters: queryParams),
    );

    return data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    final data = await _sendRequest(
      () async => await _dio.post(url, data: body),
    );

    return data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> body,
  ) async {
    final data = _sendRequest(() async => await _dio.put(url, data: body));

    return data as Map<String, dynamic>;
  }

  Future<Dio> _prepareDio(Dio dio) async {
    JiraAuthModel jiraAuthModel = await _jiraAuthRepository.read();
    dio.options.baseUrl = "https://${jiraAuthModel.workspace}";
    dio.options.headers = {
      "Authorization": "Basic ${_jiraAuthRepository.getAccessToken()}",
    };

    return dio;
  }

  Future<dynamic> _sendRequest(Future<Response> Function() request) async {
    try {
      _prepareDio(_dio);

      final response = await request();

      if (_isResponseSuccess(response)) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } catch (e, s) {
      if (e is DioException && e.response != null) {
        if (e.response!.statusCode == HttpStatus.unauthorized) {
          throw JiraAuthenticationFailure(
            exception: e,
            statusCode: e.response!.statusCode,
            stackTrace: e.stackTrace,
          );
        }
        if (e.response!.statusCode == HttpStatus.forbidden) {
          throw JiraAccessDeniedFailure(
            exception: e,
            statusCode: e.response!.statusCode,
            stackTrace: e.stackTrace,
          );
        }
      }

      NetworkFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        statusCode: e is DioException ? e.response!.statusCode : null,
        stackTrace: s,
      );
    }
    return null;
  }

  bool _isResponseSuccess(Response response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }
}
