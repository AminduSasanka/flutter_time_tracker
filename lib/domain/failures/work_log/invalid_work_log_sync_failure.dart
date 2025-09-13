import 'package:flutter_time_tracker/domain/failures/failure.dart';

class InvalidWorkLogSyncFailure extends Failure {
  InvalidWorkLogSyncFailure({
    super.exception,
    super.statusCode,
    super.stackTrace,
    required super.message,
  });
}
