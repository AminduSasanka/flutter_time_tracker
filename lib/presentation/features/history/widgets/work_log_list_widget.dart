import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_widget.dart';

class WorkLogListWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
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
