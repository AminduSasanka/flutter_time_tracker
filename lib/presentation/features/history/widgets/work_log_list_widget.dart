import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_widget.dart';

class WorkLogListWidget extends StatelessWidget {
  final List<WorkLog> workLogs;
  final String listTitle;

  const WorkLogListWidget({
    super.key,
    required this.workLogs,
    required this.listTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: workLogs.length,
              itemBuilder: (context, index) {
                final workLog = workLogs[index];

                return WorkLogWidget(
                  taskKey: workLog.taskKey,
                  summary: workLog.summary,
                  startTime: workLog.startTime == null ? DateTime.now() : workLog.startTime!,
                  spentTime: workLog.timeSpent == null ? "00:00" : workLog.timeSpent!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
