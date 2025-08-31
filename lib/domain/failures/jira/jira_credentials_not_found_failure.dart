import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraCredentialsNotFoundFailure extends Failure {
  JiraCredentialsNotFoundFailure({
    super.exception,
    super.statusCode,
    super.stackTrace,
  }) : super(message: "Jira authentication info not found");
}
