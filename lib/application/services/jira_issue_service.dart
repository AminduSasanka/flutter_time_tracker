import 'package:flutter_time_tracker/data/models/jira_issue_model.dart';
import 'package:flutter_time_tracker/domain/failures/failure.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_issue_repository.dart';
import 'package:flutter_time_tracker/domain/services/i_jira_issue_service.dart';
import 'package:multiple_result/multiple_result.dart';

class JiraIssueService implements IJiraIssueService {
  final IJiraIssueRepository _jiraIssueRepository;

  JiraIssueService(this._jiraIssueRepository);

  @override
  Future<Result<List<JIraIssueModel>, Failure>> searchIssue(
    String searchTerm,
  ) async {
    try {
      List<JIraIssueModel> jiraIssueModels = await _jiraIssueRepository
          .getJiraIssues(searchTerm);

      return Result.success(jiraIssueModels);
    } catch (e, s) {
      if (e is Failure) {
        return Result.error(e);
      } else {
        return Result.error(
          UnknownFailure(exception: e as Exception, stackTrace: s),
        );
      }
    }
  }
}
