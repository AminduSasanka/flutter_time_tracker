import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/service_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/state/history_screen_state.dart';

class HistoryScreenController
    extends AutoDisposeAsyncNotifier<HistoryScreenState> {
  @override
  Future<HistoryScreenState> build() async {
    Map<String, List<WorkLog>> workLogs = await _getInitialWorkLogs(
      states: [WorkLogStateEnum.completed, WorkLogStateEnum.synced],
    );

    return HistoryScreenState(
      workLogs: workLogs,
      isError: false,
      errorMessage: null,
      selectedWorkLogIds: [],
      currentPage: 1,
      hasMore: true,
      isLoading: false,
    );
  }

  Future<void> deleteWorkLog(int id) async {
    try {
      state = const AsyncLoading();

      final result = await ref.read(workLogServiceProvider).deleteWorkLog(id);

      if (result.isSuccess()) {
        state = AsyncData(
          state.value!.copyWith(
            workLogs: await _getInitialWorkLogs(
              states: [WorkLogStateEnum.completed, WorkLogStateEnum.synced],
            ),
            isError: false,
            errorMessage: null,
          ),
        );
      } else {
        state = AsyncError(result.tryGetError()!, StackTrace.current);
      }
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> filterWorkLogs({
    List<WorkLogStateEnum>? worklogStates,
    DateTime? startDate,
    String? taskKey,
  }) async {
    state = const AsyncLoading();

    final result = await ref
        .read(workLogServiceProvider)
        .getFilteredWorkLogs(
          states: worklogStates,
          startDate: startDate,
          taskKey: taskKey,
        );

    if (result.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(
          workLogs: result.tryGetSuccess(),
          isError: false,
          errorMessage: null,
          filterStartDate: startDate,
          filterTaskKey: taskKey,
          filterStates: worklogStates,
        ),
      );
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
    }
  }

  Future<Map<String, List<WorkLog>>> _getInitialWorkLogs({
    List<WorkLogStateEnum>? states,
    DateTime? startDate,
    String? taskKey,
  }) async {
    final result = await ref
        .read(workLogServiceProvider)
        .getFilteredWorkLogs(
          states: states,
          startDate: startDate,
          taskKey: taskKey,
        );

    if (result.isSuccess()) {
      Map<String, List<WorkLog>>? workLogs = result.tryGetSuccess();

      return workLogs!;
    }

    return {};
  }

  Future<void> loadMore() async {
    if (!state.value!.hasMore! || state.value!.isLoading!) return;

    state = AsyncData(state.value!.copyWith(isLoading: true));

    final result = await ref
        .read(workLogServiceProvider)
        .getFilteredWorkLogs(
          states: state.value!.filterStates,
          startDate: state.value!.filterStartDate,
          taskKey: state.value!.filterTaskKey,
          page: state.value!.currentPage + 1,
          pageSize: 10,
        );

    if (result.isSuccess()) {
      Map<String, List<WorkLog>>? newWorkLogsByDates = result.tryGetSuccess();

      if (newWorkLogsByDates != null && newWorkLogsByDates.isNotEmpty) {
        final updatedWorkLogs = Map<String, List<WorkLog>>.from(state.value!.workLogs);

        newWorkLogsByDates.forEach((key, value) {
          if (updatedWorkLogs.containsKey(key)) {
            updatedWorkLogs[key] = [...updatedWorkLogs[key]!, ...value];
          } else {
            updatedWorkLogs[key] = value;
          }
        });

        state = AsyncData(
          state.value!.copyWith(
            workLogs: updatedWorkLogs,
            isLoading: false,
            currentPage: state.value!.currentPage + 1,
          ),
        );
      } else {
        state = AsyncData(
          state.value!.copyWith(hasMore: false, isLoading: false),
        );
      }
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);
    }
  }

  void selectWorkLog(int id) {
    state = AsyncData(
      state.value!.copyWith(
        selectedWorkLogIds: [...state.value!.selectedWorkLogIds, id],
      ),
    );
  }

  void deselectWorkLog(int id) {
    state = AsyncData(
      state.value!.copyWith(
        selectedWorkLogIds: state.value!.selectedWorkLogIds
            .where((element) => element != id)
            .toList(),
      ),
    );
  }

  Future<bool> deleteSelectedWorkLogs() async {
    if (state.value!.selectedWorkLogIds.isEmpty) {
      return false;
    }

    List<int> selectedWorkLogIds = state.value!.selectedWorkLogIds;
    state = const AsyncLoading();

    final result = await ref
        .read(workLogServiceProvider)
        .bulkDeleteWorkLogs(selectedWorkLogIds);

    if (result.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(
          workLogs: await _getInitialWorkLogs(
            states: [WorkLogStateEnum.completed, WorkLogStateEnum.synced],
          ),
          isError: false,
          errorMessage: null,
          selectedWorkLogIds: [],
        ),
      );

      return true;
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);

      return false;
    }
  }

  Future<bool> syncSelectedWorkLogs() async {
    if (state.value!.selectedWorkLogIds.isEmpty) {
      return false;
    }

    List<int> selectedWorkLogIds = state.value!.selectedWorkLogIds;
    state = const AsyncLoading();

    final result = await ref
        .read(jiraWorkLogServiceProvider)
        .bulkSyncWorkLogs(selectedWorkLogIds);

    if (result.isSuccess()) {
      state = AsyncData(
        state.value!.copyWith(
          workLogs: await _getInitialWorkLogs(
            states: [WorkLogStateEnum.completed, WorkLogStateEnum.synced],
          ),
          isError: false,
          errorMessage: null,
          selectedWorkLogIds: [],
        ),
      );

      return true;
    } else {
      state = AsyncError(result.tryGetError()!, StackTrace.current);

      return false;
    }
  }

  void bulkSelectWorkLog(List<int> ids) {
    state = AsyncData(
      state.value!.copyWith(
        selectedWorkLogIds: [...state.value!.selectedWorkLogIds, ...ids],
      ),
    );
  }

  void bulkDeselectWorkLog(List<int> ids) {
    state = AsyncData(
      state.value!.copyWith(
        selectedWorkLogIds: state.value!.selectedWorkLogIds
            .where((element) => !ids.contains(element))
            .toList(),
      ),
    );
  }
}
