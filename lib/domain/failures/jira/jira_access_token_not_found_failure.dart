import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraAccessTokenNotFoundFailure extends Failure {
  JiraAccessTokenNotFoundFailure({super.exception, super.statusCode, super.stackTrace})
      : super(message: "Jira connection failed. Please check you jira credentials.");
}
