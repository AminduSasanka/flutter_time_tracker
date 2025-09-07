import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/work_log_form_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddWorkLogWidget extends ConsumerStatefulWidget {
  const AddWorkLogWidget({super.key});

  @override
  ConsumerState<AddWorkLogWidget> createState() => _AddWorkLogWidgetState();
}

class _AddWorkLogWidgetState extends ConsumerState<AddWorkLogWidget> {
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

  void saveWorkLog() async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    if (_formKey.currentState!.validate()) {
      final isWorkLogAdded = await ref
          .read(addWorkLogScreenControllerProvider.notifier)
          .addWorkLog(
        taskKey: _taskIdController.text,
        summary: _summaryController.text,
        description: _descriptionController.text,
        timeSpent: _spentTimeController.text,
        startDate: _startDateController.text,
      );

      if (isWorkLogAdded) {
        router.go(historyRoute);

        messenger.showSnackBar(
          const SnackBar(content: Text('Work log saved successfully.')),
        );
      } else {
        messenger.showSnackBar(
          const SnackBar(content: Text('Failed to add work log.')),
        );
      }
    } else {
      messenger.showSnackBar(SnackBar(content: Text('Please fill in all fields.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(addWorkLogScreenControllerProvider);

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
        if (_startDateController.text.isEmpty &&
            state.workLog.startTime != null) {
          _startDateController.text = DateFormat(
            'yyyy-MM-dd HH:mm',
          ).format(state.workLog.startTime!);
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: WorkLogFormWidget(
            taskIdController: _taskIdController,
            summaryController: _summaryController,
            descriptionController: _descriptionController,
            spentTimeController: _spentTimeController,
            startTimeController: _startDateController,
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
