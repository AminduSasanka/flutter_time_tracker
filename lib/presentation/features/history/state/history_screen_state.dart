import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class HistoryScreenState {
  List<WorkLog> workLogs = [];
  bool isError = false;
  String? errorMessage;
  DateTime? filterStartDate;

  HistoryScreenState({
    required this.workLogs,
    required this.isError,
    required this.errorMessage,
    required this.filterStartDate,
  });

  HistoryScreenState copyWith({
    List<WorkLog>? workLogs,
    bool? isError,
    String? errorMessage,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
  }) {
    return HistoryScreenState(
      workLogs: workLogs ?? this.workLogs,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      filterStartDate: filterStartDate ?? this.filterStartDate,
    );
  }
}