import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';

class TodaySummary extends ConsumerWidget {
  const TodaySummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today Summary', style: TextStyles.title),
        SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black12, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hours", style: TextStyles.subTitle),
                      SizedBox(height: 8),
                      Text("08:47", style: TextStyles.title),
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
                      Text("23", style: TextStyles.title),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
