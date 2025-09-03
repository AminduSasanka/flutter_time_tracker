import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/start_new_work_log_widget.dart';

class CurrentWorkLogWidget extends ConsumerWidget {
  const CurrentWorkLogWidget({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workLogState = ref.watch(workLogControllerProvider);
    final bool isTimerRunning = workLogState.value?.isTimerRunning ?? false;

    return workLogState.when(
      data: (state) {
        final workLog = state.workLog;
        final _elapsedTime = state.elapsedTime;

        if (workLog == null || workLog.taskKey == "") {
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
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
