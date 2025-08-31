import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';

class SettingsScreenController
    extends AutoDisposeAsyncNotifier<SettingsScreenState> {
  @override
  Future<SettingsScreenState> build() async {
    return SettingsScreenState.initial(await _loadSavedCreds());
  }

  Future<void> updateCreds(
    String email,
    String workspace,
    String apiToken,
  ) async {
    JiraAuth jiraAuth = JiraAuth(apiToken, email, workspace);

    try {
      state = AsyncValue.data(
        state.value!.copyWith(isLoading: true, jiraAuth: jiraAuth, error: ""),
      );

      await ref.read(jiraAuthServiceProvider).update(jiraAuth);

      state = AsyncValue.data(
        state.value!.copyWith(isLoading: false, error: ""),
      );
    } catch (e) {
      state = AsyncValue.data(
        state.value!.copyWith(isLoading: false, error: e.toString()),
      );
    }
  }

  Future<JiraAuth?> _loadSavedCreds() async {
    final jiraAuthResult = await ref.read(jiraAuthServiceProvider).read();

    if (jiraAuthResult.isSuccess()) {
      return jiraAuthResult.tryGetSuccess();
    }

    return null;
  }

  Future<bool> testConnection() async {
    if (state.value == null) return false;

    try {
      state = AsyncValue.data(
        state.value!.copyWith(isConnectionTesting: true, error: ""),
      );

      final testResult = await ref
          .read(jiraAuthServiceProvider)
          .testConnection();

      if (testResult.isSuccess()) {
        state = AsyncValue.data(
          state.value!.copyWith(isConnectionTesting: false, error: ""),
        );

        return true;
      }

      state = AsyncValue.data(
        state.value!.copyWith(
          isConnectionTesting: false,
          error: "Connection failed",
        ),
      );

      return false;
    } catch (e) {
      state = AsyncValue.data(
        state.value!.copyWith(isConnectionTesting: false, error: e.toString()),
      );

      return false;
    }
  }
}
