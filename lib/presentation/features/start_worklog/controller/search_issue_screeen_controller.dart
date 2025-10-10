import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/presentation/features/start_worklog/state/search_issue_screen_state.dart';

class SearchIssueScreenController
    extends AutoDisposeAsyncNotifier<SearchIssueScreenState> {
  @override
  FutureOr<SearchIssueScreenState> build() {
    return SearchIssueScreenState.initial();
  }

  Future<void> searchIssues(String query) async {
    state = AsyncData(state.value!.copyWith(isLoading: true));

    final searchResult = await ref.read(jiraIssueServiceProvider).searchIssue(query);

    if(searchResult.isSuccess()) {
      state = AsyncData(state.value!.copyWith(searchResults: searchResult.tryGetSuccess()));
    } else {
      state = AsyncError(searchResult.tryGetError()!, StackTrace.current);
    }
  }
}
