import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/application/services/jira_auth_service.dart';
import 'package:flutter_time_tracker/application/services/work_log_service.dart';
import 'package:flutter_time_tracker/core/DI/repository_providers.dart';
import 'package:flutter_time_tracker/domain/services/i_jira_auth_service.dart';
import 'package:flutter_time_tracker/domain/services/i_work_log_service.dart';

final jiraAuthServiceProvider = Provider<IJiraAuthService>((ref) {
  return JiraAuthService(ref.read(jiraAuthRepositoryProvider));
});

final workLogServiceProvider = Provider<IWorkLogService>((ref) {
  return WorkLogService(ref.watch(workLogRepositoryProvider));
});