import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';

class SearchIssueScreenState {
  final List<JIraIssue> searchResults;
  final String? searchTerm;

  SearchIssueScreenState({required this.searchResults, this.searchTerm});

  SearchIssueScreenState copyWith({
    List<JIraIssue>? searchResults,
    String? searchTerm,
  }) {
    return SearchIssueScreenState(
      searchResults: searchResults ?? this.searchResults,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  factory SearchIssueScreenState.initial() {
    return SearchIssueScreenState(searchResults: [], searchTerm: null);
  }
}
