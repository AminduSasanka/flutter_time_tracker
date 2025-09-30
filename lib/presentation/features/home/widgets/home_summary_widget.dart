import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/summary_widget.dart';

class HomeSummaryWidget extends ConsumerWidget {
  const HomeSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryState = ref.watch(homePageControllerProvider);

    return summaryState.when(
      data: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummaryWidget(
              title: "Today Summary",
              hours: state.todayHours,
              tasksCount: state.todayTasksCount,
            ),
            SizedBox(height: 18),
            SummaryWidget(
              title: "Week Summary",
              hours: state.weekHours,
              tasksCount: state.weekTasksCount,
            ),
            SizedBox(height: 18),
            SummaryWidget(
              title: "Month Summary",
              hours: state.monthHours,
              tasksCount: state.monthTasksCount,
            ),
          ],
        );
      },
      error: (error, stack) => Text('Error: $error, Stack: $stack '),
      loading: () => Center(child: const CircularProgressIndicator()),
    );
  }
}
