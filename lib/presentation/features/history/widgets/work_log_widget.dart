import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';

class WorkLogWidget extends ConsumerWidget {
  final WorkLog workLog;

  const WorkLogWidget({super.key, required this.workLog});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRect(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white60,
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1),
            right: BorderSide(color: Colors.black12, width: 1),
            bottom: BorderSide(color: Colors.black12, width: 1),
            left: BorderSide(color: Colors.blue, width: 1),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workLog.taskKey,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  workLog.summary,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            const Spacer(),
            Text(
              workLog.timeSpent == null ? "00:00" : workLog.timeSpent!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
