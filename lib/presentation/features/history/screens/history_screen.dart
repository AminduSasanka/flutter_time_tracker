import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_list_widget.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyScreenState = ref.watch(historyScreenControllerProvider);

    return historyScreenState.when(
      data: (state) {
        final List<WorkLog> workLogs = state.workLogs;

        return Scaffold(
          appBar: AppBar(title: Text("History")),
          body: WorkLogListWidget(workLogs: workLogs, listTitle: "Work log history")
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
