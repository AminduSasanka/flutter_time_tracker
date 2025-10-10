import 'package:flutter_time_tracker/data/dto/jira_issue/search_jira_issues_response_dto.dart';
import 'package:flutter_time_tracker/data/models/jira_issue_model.dart';
import 'package:flutter_time_tracker/data/sources/remote/jira/i_jira_api_service.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_jira_issue_repository.dart';

class JiraIssueRepository implements IJiraIssueRepository {
  final IJiraApiService _jiraApiService;

  JiraIssueRepository(this._jiraApiService);

  @override
  Future<List<JIraIssueModel>> getJiraIssues(String searchTerm) async {
    try {
      final response = await _jiraApiService.get(
        "/issue/picker?query=$searchTerm",
        {},
      );

      SearchJiraIssueResponseDto searchResponseDto = SearchJiraIssueResponseDto.fromJson(response);
      List<JIraIssueModel> jiraIssueModels = [];

      for (var section in searchResponseDto.sections) {
        for (var issue in section.issues) {
          jiraIssueModels.add(JIraIssueModel(
            id: issue.id,
            img: issue.img,
            key: issue.key,
            keyHtml: issue.keyHtml,
            summary: issue.summary,
            summaryText: issue.summaryText,
          ));
        }
      }

      return jiraIssueModels;
    } catch (e) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: StackTrace.current,
      );
    }
  }
}
