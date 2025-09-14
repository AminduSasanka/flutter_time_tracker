import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraResourceNotFoundFailure extends Failure {
  JiraResourceNotFoundFailure({
    super.exception,
    super.statusCode,
    super.stackTrace,
  }) : super(
         message:
             "The resource you are trying to access does not exist on jira. Please check your entries.",
       );
}
