import 'package:dio/dio.dart';
import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class NetworkInterceptor extends Interceptor {
  final IJiraAuthRepository _jiraAuthRepository;

  NetworkInterceptor(this._jiraAuthRepository);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      JiraAuthModel jiraAuthModel = await _jiraAuthRepository.read();

      options.baseUrl = "https://${jiraAuthModel.workspace}/rest/api/3";
      options.headers['content-type'] = 'application/json';
      options.headers['accept'] = 'application/json';

      if (jiraAuthModel.apiToken != "") {
        options.headers['Authorization'] =
            "Basic ${await _jiraAuthRepository.getAccessToken()}";
      }

      super.onRequest(options, handler);
    } on Failure catch (e, s) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: e,
          stackTrace: s,
        ),
      );
    } catch (e, s) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: UnknownFailure(
            exception: e is Exception ? e : Exception(e.toString()),
            statusCode: null,
            stackTrace: s,
          ),
          stackTrace: s,
        ),
      );
    }
  }
}
