import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/core/theme/primary_button.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:intl/intl.dart';

class WorkLogFormWidget extends StatelessWidget {
  final WorkLog? workLog;
  final TextEditingController taskIdController;
  final TextEditingController summaryController;
  final TextEditingController descriptionController;
  final TextEditingController spentTimeController;
  final TextEditingController startTimeController;
  final GlobalKey<FormState> formKey;
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
    required this.onSave,
  });

  Future<void> pickDateTime({context, WorkLog? worklog}) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: worklog != null ? worklog.startTime! : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    startTimeController.text = DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Task ID',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: taskIdController,
                decoration: const InputDecoration(hint: Text("ABC-2314")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your jira task ID';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: summaryController,
                decoration: const InputDecoration(hint: Text("Team meeting")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your work log summary';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 5,
                controller: descriptionController,
                decoration: const InputDecoration(
                  hint: Text("Discussed about next CR"),
                ),
              ),
              const SizedBox(height: 16),
              Text("Date"),
              SizedBox(height: 4),
              TextField(
                controller: startTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select Date",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  pickDateTime(context: context, worklog: workLog);
                },
              ),
              SizedBox(height: 16),
              const Text(
                'Time Spent',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: spentTimeController,
                decoration: const InputDecoration(hint: Text("3h 04m 23s")),
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
              const SizedBox(height: 24),
              PrimaryButton(text: "Save", onPressed: onSave, isLoading: false),
            ],
          ),
        ),
      ],
    );
  }
}
