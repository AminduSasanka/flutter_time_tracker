import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class HistoryScreenState {
  Map<String, List<WorkLog>> workLogs = {};
  bool isError = false;
  String? errorMessage;
  DateTime? filterStartDate;
  String? filterTaskKey;
  List<WorkLogStateEnum>? filterStates;
  List<int> selectedWorkLogIds = [];

  HistoryScreenState({
    required this.workLogs,
    required this.isError,
    required this.errorMessage,
    this.filterStartDate,
    this.filterTaskKey,
    this.filterStates,
    this.selectedWorkLogIds = const [],
  });

  HistoryScreenState copyWith({
    Map<String, List<WorkLog>>? workLogs,
    bool? isError,
    String? errorMessage,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    String? filterTaskKey,
    List<WorkLogStateEnum>? filterStates,
    List<int>? selectedWorkLogIds,
  }) {
    return HistoryScreenState(
      workLogs: workLogs ?? this.workLogs,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      filterStartDate: filterStartDate,
      filterTaskKey: filterTaskKey,
      filterStates: filterStates,
      selectedWorkLogIds: selectedWorkLogIds ?? this.selectedWorkLogIds,
    );
  }
}