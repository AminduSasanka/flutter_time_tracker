import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_widget.dart';

class WorkLogListWidget extends ConsumerWidget {
  final List<WorkLog> workLogs;
  final String listTitle;
  final List<int> selectedWorkLogIds;

  const WorkLogListWidget({
    super.key,
    required this.workLogs,
    required this.listTitle,
    required this.selectedWorkLogIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAllSelected = workLogs
        .map((workLog) => workLog.id)
        .every((id) => selectedWorkLogIds.contains(id));

    void handleSelections() {
      if (isAllSelected) {
        ref
            .read(historyScreenControllerProvider.notifier)
            .bulkDeselectWorkLog(
              workLogs.map((workLog) => workLog.id!).toList(),
            );
      } else {
        ref
            .read(historyScreenControllerProvider.notifier)
            .bulkSelectWorkLog(workLogs.map((workLog) => workLog.id!).toList());
      }
    }

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                listTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: handleSelections,
                child: Text(
                  isAllSelected
                      ? 'Unselect ${workLogs.length} items'
                      : 'Select all ${workLogs.length} items',
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: workLogs.length,
            itemBuilder: (context, index) {
              final workLog = workLogs[index];

              return WorkLogWidget(
                workLog: workLog,
                isSelected: selectedWorkLogIds.contains(workLog.id),
                isSelectionMode: selectedWorkLogIds.isNotEmpty,
              );
            },
          ),
        ],
      ),
    );
  }
}
