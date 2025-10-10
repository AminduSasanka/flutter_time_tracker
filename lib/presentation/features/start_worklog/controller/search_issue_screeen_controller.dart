import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';
import 'package:flutter_time_tracker/presentation/features/start_worklog/state/search_issue_screen_state.dart';

class SearchIssueScreenController
    extends AutoDisposeAsyncNotifier<SearchIssueScreenState> {
  @override
  FutureOr<SearchIssueScreenState> build() {
    return SearchIssueScreenState.initial();
  }

  Future<void> searchIssues(String query) async {
    state = const AsyncLoading();

    final searchResult = await ref
        .read(jiraIssueServiceProvider)
        .searchIssue(query);

    if (searchResult.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(
          searchResults: searchResult.tryGetSuccess(),
          searchTerm: query,
        ),
      );
    } else {
      state = AsyncError(searchResult.tryGetError()!, StackTrace.current);
    }
  }

  Future<void> clearSearchResults() async {
    state = AsyncData(
      state.value!.copyWith(searchResults: [], searchTerm: null),
    );
  }

  Future<bool> startWorkLog(JIraIssue jiraIssue) async {
    final previousState = state.value;
    state = AsyncLoading();

    final result = await ref
        .read(workLogServiceProvider)
        .startWorkLogFromJiraIssue(jiraIssue);

    if (result.isSuccess()) {
      if (result.tryGetSuccess() != null) {
        clearSearchResults();

        return true;
      } else {
        state = AsyncData(
          state.value!.copyWith(
            searchResults: previousState?.searchResults,
            searchTerm: previousState?.searchTerm,
          ),
        );

        return false;
      }
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);

      return false;
    }
  }
}
