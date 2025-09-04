import 'package:flutter_time_tracker/domain/failures/failure.dart';

class WorkLogNotFoundFailure extends Failure {
  WorkLogNotFoundFailure({super.exception, super.statusCode, super.stackTrace})
      : super(message: "Work log not found.");
}