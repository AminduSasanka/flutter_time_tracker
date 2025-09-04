import 'package:flutter/material.dart';

class WorkLogWidget extends StatelessWidget {
  final String taskKey;
  final String summary;
  final DateTime startTime;
  final String spentTime;

  const WorkLogWidget({
    super.key,
    required this.taskKey,
    required this.summary,
    required this.startTime,
    required this.spentTime,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white60,
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1),
            right: BorderSide(color: Colors.black12, width:1),
            bottom: BorderSide(color: Colors.black12, width: 1),
            left: BorderSide(color: Colors.blue, width: 1),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskKey,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  summary,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

              ],
            ),
            const Spacer(),
            Text(
              spentTime,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
