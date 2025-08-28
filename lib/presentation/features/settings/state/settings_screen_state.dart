import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';

class SettingsScreenState {
  final bool isLoading;
  final JiraAuth jiraAuth;

  SettingsScreenState(this.isLoading, this.jiraAuth);

  factory SettingsScreenState.initial() {
    return SettingsScreenState(true, JiraAuth("", "", ""));
  }

  SettingsScreenState copyWith(bool? isLoading, JiraAuth? jiraAuth) {
    return SettingsScreenState(
      isLoading ?? this.isLoading,
      jiraAuth ?? this.jiraAuth,
    );
  }
}
