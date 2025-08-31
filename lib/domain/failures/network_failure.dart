import 'package:flutter_time_tracker/domain/failures/failure.dart';

class NetworkFailure extends Failure {
  NetworkFailure({super.exception, super.statusCode, super.stackTrace})
      : super(message: "Unknown failure occurred. Please try again later.");
}
