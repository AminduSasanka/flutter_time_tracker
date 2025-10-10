import 'package:flutter_time_tracker/data/models/jira_issue_model.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IJiraIssueService {
  Future<Result<List<JIraIssueModel>, Failure>> searchIssue(String searchTerm);
}
