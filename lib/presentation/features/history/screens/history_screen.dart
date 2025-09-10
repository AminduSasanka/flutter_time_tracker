import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/history_filters_widget.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/history_screen_menu.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_list_widget.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyScreenState = ref.watch(historyScreenControllerProvider);

    return historyScreenState.when(
      data: (state) {
        final Map<String, List<WorkLog>> workLogsGroupedByDate = state.workLogs;
        final List<int> selectedWorkLogIds = state.selectedWorkLogIds;

        void showFilterSheet() {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return HistoryFilterWidget();
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("History", style: TextStyles.appBarTitle),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_alt_outlined),
                onPressed: showFilterSheet,
              ),
              HistoryScreenMenu(
                isSelectionMode: selectedWorkLogIds.isNotEmpty,
                screenContext: context,
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: workLogsGroupedByDate.length,
            itemBuilder: (context, index) {
              final date = workLogsGroupedByDate.keys.elementAt(index);
              final workLogs = workLogsGroupedByDate[date]!;

              return WorkLogListWidget(
                workLogs: workLogs,
                listTitle: date,
                selectedWorkLogIds: selectedWorkLogIds,
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
