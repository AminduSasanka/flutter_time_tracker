import 'package:flutter_time_tracker/data/models/jira_issue_model.dart';

abstract interface class IJiraIssueRepository {
  Future<List<JIraIssueModel>> getJiraIssues(String searchTerm);
}