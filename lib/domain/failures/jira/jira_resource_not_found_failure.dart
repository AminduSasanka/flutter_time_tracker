import 'package:flutter_time_tracker/domain/failures/failure.dart';

class JiraResourceNotFoundFailure extends Failure {
  JiraResourceNotFoundFailure({
    super.exception,
    super.statusCode,
    super.stackTrace,
  }) : super(
         message:
             "The resource you are looking for does not exist. Please check your task ID(s)",
       );
}
