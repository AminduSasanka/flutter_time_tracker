import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraAuthenticationFailure extends Failure {
  JiraAuthenticationFailure({super.exception, super.statusCode, super.stackTrace})
      : super(message: "Jira authentication error. Please check your jira credentials.");
}
