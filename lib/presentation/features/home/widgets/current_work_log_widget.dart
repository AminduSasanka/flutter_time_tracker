import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/start_new_work_log_widget.dart';

class CurrentWorkLogWidget extends ConsumerStatefulWidget {
  const CurrentWorkLogWidget({super.key});

  @override
  ConsumerState<CurrentWorkLogWidget> createState() =>
      _CurrentWorkLogWidgetState();
}

class _CurrentWorkLogWidgetState extends ConsumerState<CurrentWorkLogWidget> {
  @override
  Widget build(BuildContext context) {
    final workLogState = ref.watch(workLogControllerProvider);
    final workLog = workLogState.workLog;

    if (workLog == null) {
      return StartNewWorkLogWidget();
    }

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("00 : 00 : 00", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 16),
                  Text(workLog.taskKey, style: TextStyle(fontSize: 20)),
                  Text(workLog.summary, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: workLogState.isTimerRunning
                  ? Icon(Icons.pause, size: 50)
                  : Icon(Icons.play_circle, size: 50),
            ),
            workLogState.isTimerRunning
                ? IconButton(onPressed: () {}, icon: Icon(Icons.stop, size: 50))
                : Container(),
          ],
        ),
      ),
    );
  }
}
