import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IJiraIssueService {
  Future<Result<List<JIraIssue>, Failure>> searchIssue(String searchTerm);
}
