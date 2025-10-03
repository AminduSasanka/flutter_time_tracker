import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/presentation/features/start_worklog/widgets/start_new_work_log_widget.dart';

class StartWorklogScreen extends StatelessWidget {
  const StartWorklogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Work Log', style: TextStyles.title,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 8,
            right: 8,
            bottom: 16,
          ),
          child: StartNewWorkLogWidget(),
        ),
      ),
    );
  }
}
