import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/duration_to_spent_time.dart';

class SummaryWidget extends StatelessWidget {
  final String title;
  final Duration hours;
  final int tasksCount;

  const SummaryWidget({
    super.key,
    required this.title,
    required this.hours,
    required this.tasksCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.title),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black12, width: 1.0),
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
                      Text(durationToSpentTime(hours), style: TextStyles.title),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black12, width: 1.0),
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
                      Text(tasksCount.toString(), style: TextStyles.title),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
