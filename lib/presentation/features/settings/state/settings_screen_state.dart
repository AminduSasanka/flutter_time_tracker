import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';

class SettingsScreenState {
  final bool isLoading;
  final JiraAuth jiraAuth;
  final String error;

  SettingsScreenState(this.isLoading, this.jiraAuth, this.error);

  factory SettingsScreenState.initial(JiraAuth? initialJiraAuth) {
    return SettingsScreenState(false, initialJiraAuth ?? JiraAuth("", "", ""), "");
  }

  SettingsScreenState copyWith(bool? isLoading, JiraAuth? jiraAuth, String? error) {
    return SettingsScreenState(
      isLoading ?? this.isLoading,
      jiraAuth ?? this.jiraAuth,
      error ?? this.error,
    );
  }
}
