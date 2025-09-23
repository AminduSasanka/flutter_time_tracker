import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/state/add_worklog_screen_state.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/work_log_form_widget.dart';
import 'package:intl/intl.dart';

class AddWorkLogWidget extends StatelessWidget {
  final AddWorklogScreenState state;
  final TextEditingController taskIdController;
  final TextEditingController summaryController;
  final TextEditingController descriptionController;
  final TextEditingController spentTimeController;
  final TextEditingController startDateController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  const AddWorkLogWidget({
    super.key,
    required this.state,
    required this.taskIdController,
    required this.summaryController,
    required this.descriptionController,
    required this.spentTimeController,
    required this.startDateController,
    required this.formKey,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    if (taskIdController.text.isEmpty && state.workLog.taskKey != "") {
      taskIdController.text = state.workLog.taskKey;
    }
    if (descriptionController.text.isEmpty &&
        state.workLog.description != null) {
      descriptionController.text = state.workLog.description!;
    }
    if (summaryController.text.isEmpty && state.workLog.summary != "") {
      summaryController.text = state.workLog.summary;
    }
    if (spentTimeController.text.isEmpty && state.workLog.timeSpent != null) {
      spentTimeController.text = state.workLog.timeSpent!;
    }
    if (startDateController.text.isEmpty && state.workLog.startTime != null) {
      startDateController.text = DateFormat(
        'yyyy-MM-dd HH:mm',
      ).format(state.workLog.startTime!);
    }

    return WorkLogFormWidget(
      taskIdController: taskIdController,
      summaryController: summaryController,
      descriptionController: descriptionController,
      spentTimeController: spentTimeController,
      startTimeController: startDateController,
      formKey: formKey,
      onSave: onSave,
    );
  }
}
