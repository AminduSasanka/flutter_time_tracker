import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/widgets/add_work_log_widget.dart';

class AddWorklogScreen extends ConsumerStatefulWidget {
  const AddWorklogScreen({super.key});

  @override
  ConsumerState<AddWorklogScreen> createState() => _AddWorklogScreenState();
}

class _AddWorklogScreenState extends ConsumerState<AddWorklogScreen> {
  late final TextEditingController _taskIdController;
  late final TextEditingController _summaryController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _spentTimeController;
  late final TextEditingController _startDateController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _taskIdController = TextEditingController();
    _summaryController = TextEditingController();
    _descriptionController = TextEditingController();
    _spentTimeController = TextEditingController();
    _startDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskIdController.dispose();
    _summaryController.dispose();
    _descriptionController.dispose();
    _spentTimeController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  Future<bool> _saveWorkLog() async {
    final isWorkLogAdded = await ref
        .read(addWorkLogScreenControllerProvider.notifier)
        .addWorkLog(
      taskKey: _taskIdController.text,
      summary: _summaryController.text,
      description: _descriptionController.text,
      timeSpent: _spentTimeController.text,
      startDate: _startDateController.text,
    );

    return isWorkLogAdded;
  }

  void _clearInputs() {
    _taskIdController.clear();
    _summaryController.clear();
    _descriptionController.clear();
    _spentTimeController.clear();
    _startDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(addWorkLogScreenControllerProvider);

    void handleAddWorkLog() async {
      if (_formKey.currentState!.validate()) {
        bool isWorkLogAdded = await _saveWorkLog();

        if (isWorkLogAdded) {
          _clearInputs();

          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Work log added successfully'),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add Work Log')),
      body: AddWorkLogWidget(
        state: screenState,
        taskIdController: _taskIdController,
        summaryController: _summaryController,
        descriptionController: _descriptionController,
        spentTimeController: _spentTimeController,
        startDateController: _startDateController,
        formKey: _formKey,
        onSave: handleAddWorkLog,
      ),
    );
  }
}
