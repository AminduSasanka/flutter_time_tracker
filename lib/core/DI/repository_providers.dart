import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/source_providers.dart';
import 'package:flutter_time_tracker/core/services/network/network_service_provider.dart';
import 'package:flutter_time_tracker/data/repositories/jira_auth_repository.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_auth_repository.dart';

final jiraAuthRepositoryProvider = Provider<IJiraAuthRepository>((ref) {
  return JiraAuthRepository(
    ref.watch(secureStorageServiceProvider),
    ref.read(networkServiceProvider),
  );
});
