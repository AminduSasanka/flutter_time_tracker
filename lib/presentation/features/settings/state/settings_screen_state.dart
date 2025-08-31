import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';

class SettingsScreenState {
  final bool isLoading;
  final bool isConnectionTesting;
  final JiraAuth jiraAuth;
  final String error;

  SettingsScreenState({
    required this.isLoading,
    required this.isConnectionTesting,
    required this.jiraAuth,
    required this.error,
  });

  factory SettingsScreenState.initial(JiraAuth? initialJiraAuth) {
    return SettingsScreenState(
      isLoading: false,
      isConnectionTesting: false,
      jiraAuth: initialJiraAuth ?? JiraAuth("", "", ""),
      error: "",
    );
  }

  SettingsScreenState copyWith({
    bool? isLoading,
    bool? isConnectionTesting,
    JiraAuth? jiraAuth,
    String? error,
  }) {
    return SettingsScreenState(
      isLoading: isLoading ?? this.isLoading,
      isConnectionTesting: isConnectionTesting ?? this.isConnectionTesting,
      jiraAuth: jiraAuth ?? this.jiraAuth,
      error: error ?? this.error,
    );
  }
}
