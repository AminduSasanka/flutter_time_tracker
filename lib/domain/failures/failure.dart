abstract class Failure implements Exception {
  final Exception? exception;
  final String message;
  final int? statusCode;
  final StackTrace? stackTrace;

  Failure({
    this.exception,
    required this.message,
    this.statusCode,
    this.stackTrace,
  });
}
