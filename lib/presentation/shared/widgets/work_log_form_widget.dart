import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/core/theme/primary_button.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/form_field_input_label.dart';
import 'package:intl/intl.dart';

class WorkLogFormWidget extends StatelessWidget {
  final WorkLog? workLog;
  final TextEditingController taskIdController;
  final TextEditingController summaryController;
  final TextEditingController descriptionController;
  final TextEditingController spentTimeController;
  final TextEditingController startTimeController;
  final GlobalKey<FormState> formKey;
  final bool showAllFields;
  final void Function() onSave;

  const WorkLogFormWidget({
    super.key,
    this.workLog,
    required this.taskIdController,
    required this.summaryController,
    required this.descriptionController,
    required this.spentTimeController,
    required this.startTimeController,
    required this.formKey,
    required this.showAllFields,
    required this.onSave,
  });

  Future<void> pickDateTime({context, WorkLog? worklog}) async {
    DateTime initialDate = worklog?.startTime ?? DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date == null) return;

    TimeOfDay initialTime = TimeOfDay.fromDateTime(initialDate);
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (time == null) return;

    DateTime selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    startTimeController.text = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormFieldInputLabel(label: 'Task ID', isRequired: true),
          const SizedBox(height: 8),
          TextFormField(
            controller: taskIdController,
            decoration: const InputDecoration(hintText: "ABC-2314"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your jira task ID';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          FormFieldInputLabel(label: 'Summary', isRequired: true),
          const SizedBox(height: 8),
          TextFormField(
            controller: summaryController,
            decoration: const InputDecoration(hintText: "Team meeting"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your work log summary';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          FormFieldInputLabel(label: 'Description'),
          const SizedBox(height: 8),
          TextField(
            maxLines: 5,
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: "Discussed about next CR",
            ),
          ),
          const SizedBox(height: 16),
          FormFieldInputLabel(label: "Start Date & Time", isRequired: true),
          const SizedBox(height: 8),
          TextFormField(
            controller: startTimeController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Select Date",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
            onTap: () {
              pickDateTime(context: context, worklog: workLog);
            },
          ),

          showAllFields == true
              ? Column(
                  children: [
                    SizedBox(height: 16),
                    FormFieldInputLabel(label: 'Time Spent', isRequired: true),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: spentTimeController,
                      decoration: const InputDecoration(hintText: "3h 04m"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid time spent';
                        }

                        // Regular expression to match format: XhYmZs or XhYs or XmYs or Xh or Xm or Xs
                        RegExp timeRegex = RegExp(
                          r'^(?:(\d+)h\s*)?(?:(\d+)m\s*)?(?:(\d+)s)?$',
                          caseSensitive: false,
                        );

                        if (!timeRegex.hasMatch(value.trim())) {
                          return 'Invalid format. Use: 3h 04m 23s, 2h 30m, 45m, etc.';
                        }

                        return null;
                      },
                    ),
                  ],
                )
              : Container(),

          const SizedBox(height: 24),
          PrimaryButton(text: "Save", onPressed: onSave, isLoading: false),
        ],
      ),
    );
  }
}
