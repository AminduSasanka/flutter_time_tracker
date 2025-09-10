import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:go_router/go_router.dart';

class WorkLogWidget extends ConsumerWidget {
  final WorkLog workLog;
  final bool isSelected;
  final bool isSelectionMode;

  const WorkLogWidget({super.key, required this.workLog, this.isSelected = false, this.isSelectionMode = false});

  Widget _SelectedIconWidget() {
    return Row(
      children: [
        Icon(Icons.check_box, color: Colors.blue),
        const SizedBox(width: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRect(
      child: GestureDetector(
        onTap: () {
          if (isSelectionMode && !isSelected) {
            ref.read(historyScreenControllerProvider.notifier).selectWorkLog(workLog.id!);
          } else if (isSelectionMode && isSelected) {
            ref.read(historyScreenControllerProvider.notifier).deselectWorkLog(workLog.id!);
          } else {
            context.pushNamed(
              editWorklogRoute,
              pathParameters: {'worklogId': workLog.id!.toString()},
            );
          }
        },
        onLongPress: () {
          if (!isSelected) {
            ref.read(historyScreenControllerProvider.notifier).selectWorkLog(workLog.id!);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Colors.black12, width: 1),
              right: BorderSide(color: Colors.black12, width: 1),
              bottom: BorderSide(color: Colors.black12, width: 1),
              left: BorderSide(color: Colors.blue, width: 1),
            ),
          ),
          child: Row(
            children: [
              isSelected ? _SelectedIconWidget() : Container(),
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
      ),
    );
  }
}
