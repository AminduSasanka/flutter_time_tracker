import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

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
          body: ListView.builder(
            itemCount: workLogs.length,
            itemBuilder: (context, index) {
              final workLog = workLogs[index];
              return ListTile(
                title: Text(workLog.taskKey),
                subtitle: Text(workLog.summary),
              );
            },
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
