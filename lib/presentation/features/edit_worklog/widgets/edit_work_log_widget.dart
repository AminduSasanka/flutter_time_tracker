import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/primary_button.dart';

class EditWorkLogWidget extends ConsumerStatefulWidget {
  final int worklogId;

  const EditWorkLogWidget({super.key, required this.worklogId});

  @override
  ConsumerState<EditWorkLogWidget> createState() => _EditWorkLogWidgetState();
}

class _EditWorkLogWidgetState extends ConsumerState<EditWorkLogWidget> {
  late final TextEditingController _taskIdController;
  late final TextEditingController _summaryController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _spentTimeController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _taskIdController = TextEditingController();
    _summaryController = TextEditingController();
    _descriptionController = TextEditingController();
    _spentTimeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskIdController.dispose();
    _summaryController.dispose();
    _descriptionController.dispose();
    _spentTimeController.dispose();
    super.dispose();
  }

  void saveWorkLog() {
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(
        editWorklogScreenControllerProvider(widget.worklogId).notifier,
      );

      controller.saveWorkLog(
        taskKey: _taskIdController.text,
        summary: _summaryController.text,
        description: _descriptionController.text,
      );

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Work log saved successfully.')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(
      editWorklogScreenControllerProvider(widget.worklogId),
    );

    return screenState.when(
      data: (state) {
        if (_taskIdController.text.isEmpty && state.workLog.taskKey != "") {
          _taskIdController.text = state.workLog.taskKey;
        }
        if (_descriptionController.text.isEmpty &&
            state.workLog.description != null) {
          _descriptionController.text = state.workLog.description!;
        }
        if (_summaryController.text.isEmpty && state.workLog.summary != "") {
          _summaryController.text = state.workLog.summary;
        }
        if (_spentTimeController.text.isEmpty &&
            state.workLog.timeSpent != null) {
          _spentTimeController.text = state.workLog.timeSpent!;
        }

        return Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Task ID',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _taskIdController,
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _summaryController,
                      decoration: const InputDecoration(
                        hint: Text("Team meeting"),
                      ),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hint: Text("Discussed about next CR"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Time Spent',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _spentTimeController,
                      decoration: const InputDecoration(
                        hint: Text("3h 04m 23s"),
                      ),
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
                    PrimaryButton(
                      text: "Save",
                      onPressed: saveWorkLog,
                      isLoading: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
