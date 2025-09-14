import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraWorkLogSyncFailure extends Failure {
  JiraWorkLogSyncFailure({
    super.exception,
    super.statusCode,
    super.stackTrace,
  }) : super(message: "Unexpected response from Jira. Please try again later");
}
