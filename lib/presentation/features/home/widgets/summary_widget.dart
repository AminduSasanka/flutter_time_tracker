import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
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
        Text(title, style: TextStyles.subTitle),
        SizedBox(height: 12),
        Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black12, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsetsGeometry.directional(
              start: 16,
              end: 16,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hours", style: TextStyles.subTitle),
                          SizedBox(height: 8),
                          Text(
                            durationToSpentTime(hours),
                            style: TextStyles.title,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tasks", style: TextStyles.subTitle),
                          SizedBox(height: 8),
                          Text(tasksCount.toString(), style: TextStyles.title),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
