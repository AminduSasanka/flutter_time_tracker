import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/history_filters_widget.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_list_widget.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyScreenState = ref.watch(historyScreenControllerProvider);

    return historyScreenState.when(
      data: (state) {
        final List<WorkLog> workLogs = state.workLogs;

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
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: WorkLogListWidget(
                  workLogs: workLogs,
                  listTitle: "Work log history",
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
