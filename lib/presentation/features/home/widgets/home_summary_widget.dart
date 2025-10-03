import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/duration_to_spent_time.dart';

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
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 8,
                        bottom: 16,
                        left: 8,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Hours",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            durationToSpentTime(state.todayHours),
                            style: TextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 8,
                        bottom: 16,
                        left: 8,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Tasks",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            state.todayTasksCount.toString(),
                            style: TextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      error: (error, stack) => Text('Error: $error, Stack: $stack '),
      loading: () => Center(child: const CircularProgressIndicator()),
    );
  }
}
