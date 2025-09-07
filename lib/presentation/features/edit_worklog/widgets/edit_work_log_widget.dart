import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/work_log_form_widget.dart';
import 'package:intl/intl.dart';

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
  late final TextEditingController _startTimeController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _taskIdController = TextEditingController();
    _summaryController = TextEditingController();
    _descriptionController = TextEditingController();
    _spentTimeController = TextEditingController();
    _startTimeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskIdController.dispose();
    _summaryController.dispose();
    _descriptionController.dispose();
    _spentTimeController.dispose();
    _startTimeController.dispose();
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
        timeSpent: _spentTimeController.text,
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
        if (_startTimeController.text.isEmpty &&
            state.workLog.startTime != null) {
          _startTimeController.text = DateFormat(
            'yyyy-MM-dd',
          ).format(state.workLog.startTime!);
        }

        return Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: WorkLogFormWidget(
            taskIdController: _taskIdController,
            summaryController: _summaryController,
            descriptionController: _descriptionController,
            spentTimeController: _spentTimeController,
            startTimeController: _startTimeController,
            formKey: _formKey,
            onSave: saveWorkLog,
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
