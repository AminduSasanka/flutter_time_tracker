import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraAccessDeniedFailure extends Failure {
  JiraAccessDeniedFailure({super.exception, super.statusCode, super.stackTrace})
      : super(message: "You don't have permission to perform this action.");
}
