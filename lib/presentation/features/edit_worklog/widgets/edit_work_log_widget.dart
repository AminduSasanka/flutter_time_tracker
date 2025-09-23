import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/state/edit_worklog_screen_state.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/work_log_form_widget.dart';
import 'package:intl/intl.dart';

class EditWorkLogWidget extends StatelessWidget {
  final int worklogId;
  final EditWorklogScreenState state;
  final TextEditingController taskIdController;
  final TextEditingController summaryController;
  final TextEditingController descriptionController;
  final TextEditingController spentTimeController;
  final TextEditingController startTimeController;
  final GlobalKey<FormState> formKey;
  final void Function() onSave;

  const EditWorkLogWidget({
    super.key,
    required this.worklogId,
    required this.taskIdController,
    required this.summaryController,
    required this.descriptionController,
    required this.spentTimeController,
    required this.startTimeController,
    required this.formKey,
    required this.onSave,
    required this.state,
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
    if (startTimeController.text.isEmpty && state.workLog.startTime != null) {
      startTimeController.text = DateFormat(
        'yyyy-MM-dd HH:mm',
      ).format(state.workLog.startTime!);
    }

    return WorkLogFormWidget(
      taskIdController: taskIdController,
      summaryController: summaryController,
      descriptionController: descriptionController,
      spentTimeController: spentTimeController,
      startTimeController: startTimeController,
      formKey: formKey,
      onSave: onSave,
    );
  }
}
