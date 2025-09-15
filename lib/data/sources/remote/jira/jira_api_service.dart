import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_time_tracker/core/services/network/network_interceptor.dart';
import 'package:flutter_time_tracker/data/sources/remote/jira/i_jira_api_service.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_access_denied_failure.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_authentication_failure.dart';
import 'package:flutter_time_tracker/domain/failures/jira/jira_resource_not_found_failure.dart';
import 'package:flutter_time_tracker/domain/failures/network_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class JiraApiService implements IJiraApiService {
  final Dio _dio;
  final IJiraAuthRepository _jiraAuthRepository;
  static bool _isInitialized = false;

  JiraApiService(this._dio, this._jiraAuthRepository);

  @override
  Future<dynamic> delete(String url) async {
    final data = await _sendRequest(() async => await _dio.delete(url));

    return data;
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
    final data = await _sendRequest(
      () async => await _dio.put(url, data: body),
    );

    return data as Map<String, dynamic>;
  }

  Future<Dio> _prepareDio(Dio dio) async {
    if (_isInitialized) return dio;

    try {
      dio.interceptors.addAll([
        HttpFormatter(
          loggingFilter: (request, response, error) {
            if (response?.statusCode == 201) return false;

            return true;
          },
        ),
        NetworkInterceptor(_jiraAuthRepository),
      ]);
      _isInitialized = true;

      return dio;
    } catch (e, s) {
      if (e is Failure) {
        rethrow;
      } else {
        throw NetworkFailure(
          exception: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        );
      }
    }
  }

  Future<dynamic> _sendRequest(Future<Response> Function() request) async {
    try {
      await _prepareDio(_dio);

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
        if (e.response!.statusCode == HttpStatus.notFound) {
          throw JiraResourceNotFoundFailure(
            exception: e,
            statusCode: e.response!.statusCode,
            stackTrace: e.stackTrace,
          );
        }
      }

      if (e is DioException && e.response == null) {
        if (e.error is Failure) {
          throw e.error as Failure;
        }
      }

      if (e is Failure) {
        rethrow;
      } else {
        throw NetworkFailure(
          exception: e is Exception ? e : Exception(e.toString()),
          statusCode: e is DioException ? e.response!.statusCode : null,
          stackTrace: s,
        );
      }
    }
  }

  bool _isResponseSuccess(Response response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  void resetInitialization() {
    _isInitialized = false;
    _dio.interceptors.clear();
  }
}
