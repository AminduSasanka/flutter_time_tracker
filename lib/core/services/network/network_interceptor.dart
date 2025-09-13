import 'package:dio/dio.dart';
import 'package:flutter_time_tracker/data/models/jira_auth/jira_auth_model.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

class NetworkInterceptor extends Interceptor {
  final IJiraAuthRepository _jiraAuthRepository;

  NetworkInterceptor(this._jiraAuthRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    JiraAuthModel jiraAuthModel = await _jiraAuthRepository.read();

    options.baseUrl = "https://${jiraAuthModel.workspace}/rest/api/3";
    options.headers['content-type'] = 'application/json';
    options.headers['accept'] = 'application/json';

    if (jiraAuthModel.apiToken != "") {
      options.headers['Authorization'] =
          "Basic ${await _jiraAuthRepository.getAccessToken()}";
    }

    super.onRequest(options, handler);
  }
}
