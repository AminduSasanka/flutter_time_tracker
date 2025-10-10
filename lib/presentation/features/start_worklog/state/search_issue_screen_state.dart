import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';

class SearchIssueScreenState {
  final List<JIraIssue> searchResults;
  final bool isLoading;

  SearchIssueScreenState({
    required this.searchResults,
    required this.isLoading,
  });

  SearchIssueScreenState copyWith({
    List<JIraIssue>? searchResults,
    bool? isLoading,
  }) {
    return SearchIssueScreenState(
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory SearchIssueScreenState.initial() {
    return SearchIssueScreenState(searchResults: [], isLoading: false);
  }
}
