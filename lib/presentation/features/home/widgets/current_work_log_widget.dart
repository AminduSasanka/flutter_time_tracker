import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/start_new_work_log_widget.dart';

class CurrentWorkLogWidget extends ConsumerStatefulWidget {
  const CurrentWorkLogWidget({super.key});

  @override
  ConsumerState<CurrentWorkLogWidget> createState() =>
      _CurrentWorkLogWidgetState();
}

class _CurrentWorkLogWidgetState extends ConsumerState<CurrentWorkLogWidget> {
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workLogState = ref.watch(workLogControllerProvider);
    final WorkLog? workLog = workLogState.value?.workLog;
    final bool isTimerRunning = workLogState.value?.isTimerRunning ?? false;

    if (workLog == null || workLog.taskKey == "") {
      _timer?.cancel();
      _timer = null;

      return StartNewWorkLogWidget();
    }

    if (!workLogState.isLoading && workLog.taskKey != "") {
      _timer?.cancel();

      _elapsedTime = DateTime.now().difference(
        workLog.startTime == null ? DateTime.now() : workLog.startTime!,
      );

      if (workLog.workLogState == WorkLogStateEnum.pending && isTimerRunning) {
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (isTimerRunning) {
            setState(() {
              _elapsedTime = DateTime.now().difference(
                workLog.startTime == null ? DateTime.now() : workLog.startTime!,
              );
            });
          }
        });
      }
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
                  Text(
                    _formatDuration(_elapsedTime),
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Text(workLog.taskKey, style: TextStyle(fontSize: 20)),
                  Text(workLog.summary, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                if (isTimerRunning) {
                  await ref
                      .read(workLogControllerProvider.notifier)
                      .pauseWorkLog();
                } else {
                  await ref
                      .read(workLogControllerProvider.notifier)
                      .resumeWorkLog();
                }
              },
              icon: isTimerRunning
                  ? Icon(Icons.pause, size: 50)
                  : Icon(Icons.play_circle, size: 50),
            ),
            isTimerRunning
                ? IconButton(
                    onPressed: () async {
                      await ref
                          .read(workLogControllerProvider.notifier)
                          .stopWorkLog();
                    },
                    icon: Icon(Icons.stop, size: 50),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
