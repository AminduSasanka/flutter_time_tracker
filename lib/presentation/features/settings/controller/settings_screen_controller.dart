import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/jira_auth/jira_auth.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';

class SettingsScreenController
    extends AutoDisposeAsyncNotifier<SettingsScreenState> {
  @override
  Future<SettingsScreenState> build() async {
    return SettingsScreenState.initial(await _getSavedCreds());
  }

  Future<void> updateCreds(
    String email,
    String workspace,
    String apiToken,
  ) async {
    JiraAuth jiraAuth = JiraAuth(apiToken, email, workspace);

    try {
      state = AsyncValue.data(state.value!.copyWith(true, false, jiraAuth, ""));

      await ref.read(jiraAuthServiceProvider).update(jiraAuth);

      state = AsyncValue.data(state.value!.copyWith(false, false, jiraAuth, ""));
    } catch (e) {
      state = AsyncValue.data(
        state.value!.copyWith(false, false, jiraAuth, e.toString()),
      );
    }
  }

  Future<JiraAuth> _getSavedCreds() async {
    JiraAuth jiraAuth = await ref.read(jiraAuthServiceProvider).read();

    return jiraAuth;
  }

  Future<bool> testConnection() async {
    try {
      state = AsyncValue.data(
        state.value!.copyWith(false, true, await _getSavedCreds(), ""),
      );

      final isSuccess = await ref
          .read(jiraAuthServiceProvider)
          .testConnection();

      if (isSuccess) {
        state = AsyncValue.data(
          state.value!.copyWith(false, false, await _getSavedCreds(), ""),
        );
      } else {
        state = AsyncValue.data(
          state.value!.copyWith(
            false,
            false,
            await _getSavedCreds(),
            "Connection failed",
          ),
        );
      }

      return isSuccess;
    } catch (e) {
      state = AsyncValue.data(
        state.value!.copyWith(false, false, await _getSavedCreds(), e.toString()),
      );

      rethrow;
    }
  }
}
