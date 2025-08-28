import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';

class SettingsScreenController extends AutoDisposeNotifier<SettingsScreenState> {
  @override
  SettingsScreenState build() {
    return SettingsScreenState.initial();
  }

  Future<void> update(String email, String workspace, String apiToken) async {
    JiraAuth jiraAuth = JiraAuth(apiToken, email, workspace);

    try {
      state = state.copyWith(true, jiraAuth, "");

      await ref.read(jiraAuthServiceProvider).update(jiraAuth);

      state = state.copyWith(false, jiraAuth, "");
    } catch (e) {
      state = state.copyWith(false, jiraAuth, e.toString());
    }
  }
}