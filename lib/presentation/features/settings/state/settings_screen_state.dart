import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';

class SettingsScreenState {
  final bool isLoading;
  final bool isConnectionTesting;
  final JiraAuth jiraAuth;
  final String error;

  SettingsScreenState(
    this.isLoading,
    this.isConnectionTesting,
    this.jiraAuth,
    this.error,
  );

  factory SettingsScreenState.initial(JiraAuth? initialJiraAuth) {
    return SettingsScreenState(
      false,
      false,
      initialJiraAuth ?? JiraAuth("", "", ""),
      "",
    );
  }

  SettingsScreenState copyWith(
    bool? isLoading,
    bool? isConnectionTesting,
    JiraAuth? jiraAuth,
    String? error,
  ) {
    return SettingsScreenState(
      isLoading ?? this.isLoading,
      isConnectionTesting ?? this.isConnectionTesting,
      jiraAuth ?? this.jiraAuth,
      error ?? this.error,
    );
  }
}
