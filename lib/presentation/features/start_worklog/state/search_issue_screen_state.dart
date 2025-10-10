import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';

class SearchIssueScreenState {
  final List<JIraIssue> searchResults;

  SearchIssueScreenState({
    required this.searchResults,
  });

  SearchIssueScreenState copyWith({
    List<JIraIssue>? searchResults,
    bool? isLoading,
  }) {
    return SearchIssueScreenState(
      searchResults: searchResults ?? this.searchResults,
    );
  }

  factory SearchIssueScreenState.initial() {
    return SearchIssueScreenState(searchResults: []);
  }
}
