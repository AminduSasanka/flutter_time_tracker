import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/application/services/jira_auth_service.dart';
import 'package:flutter_time_tracker/core/DI/repository_providers.dart';

final apiTokenServiceProvider = Provider<JiraAuthService>((ref) {
  return JiraAuthService(ref.read(jiraAuthRepositoryProvider));
});