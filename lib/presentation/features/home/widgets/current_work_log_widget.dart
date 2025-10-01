import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/start_new_work_log_widget.dart';
import 'package:go_router/go_router.dart';

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

    void stopWorkLog(bool isTimerRunning) async {
      if (isTimerRunning) {
        await ref.read(workLogControllerProvider.notifier).stopWorkLog();
      }

      if (context.mounted) {
        if (!workLogState.isLoading && workLogState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${workLogState.error}')),
          );
        } else {
          ref.invalidate(homePageControllerProvider);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Work log stopped and saved')));
        }
      }
    }

    return workLogState.when(
      data: (state) {
        final workLog = state.workLog;
        final elapsedTime = state.elapsedTime;

        if (workLog == null || workLog.taskKey == "") {
          return StartNewWorkLogWidget();
        }

        return Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Current Task", style: TextStyles.subTitle),
                    IconButton(
                      onPressed: () {
                        context.pushNamed(
                          editWorklogRoute,
                          pathParameters: {
                            'worklogId': workLog.id!.toString(),
                          },
                        );
                      },
                      icon: Icon(Icons.edit_note, size: 30,),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDuration(elapsedTime),
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            workLog.taskKey,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(workLog.summary, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
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
                              ? Container()
                              : Icon(Icons.play_circle, size: 50),
                        ),
                        isTimerRunning
                            ? IconButton(
                                onPressed: () => stopWorkLog(isTimerRunning),
                                icon: Icon(Icons.stop, size: 50),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
