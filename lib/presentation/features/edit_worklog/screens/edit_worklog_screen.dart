import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/widgets/edit_work_log_widget.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/confirmation_dialog.dart';

class EditWorklogScreen extends ConsumerStatefulWidget {
  final String? worklogId;

  const EditWorklogScreen({super.key, required this.worklogId});

  @override
  ConsumerState<EditWorklogScreen> createState() => _EditWorklogScreenState();
}

class _EditWorklogScreenState extends ConsumerState<EditWorklogScreen> {
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

  @override
  Widget build(BuildContext context) {
    void deleteWorkLog() async {
      final isDeleted = await ref
          .read(
            editWorklogScreenControllerProvider(
              int.parse(widget.worklogId!),
            ).notifier,
          )
          .deleteWorkLog();

      if (context.mounted) {
        if (isDeleted) {
          ref.invalidate(historyScreenControllerProvider);
          Navigator.pop(context);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Worklog deleted successfully')),
            );
        }
      }
    }

    void saveWorkLog() async {
      final controller = ref.read(
        editWorklogScreenControllerProvider(
          int.parse(widget.worklogId!),
        ).notifier,
      );

      final isSaved = await controller.saveWorkLog(
        taskKey: _taskIdController.text,
        summary: _summaryController.text,
        description: _descriptionController.text,
        timeSpent: _spentTimeController.text,
        startTime: _startTimeController.text,
      );

      if (context.mounted) {
        if (isSaved) {
          Navigator.pop(context);
          ref.invalidate(historyScreenControllerProvider);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Worklog saved successfully')),
            );
        }
      }
    }

    void syncWorkLog() async {
      final result = await ref
          .read(
            editWorklogScreenControllerProvider(
              int.parse(widget.worklogId!),
            ).notifier,
          )
          .syncWorkLog();

      if (context.mounted) {
        if (result) {
          ref.invalidate(
            editWorklogScreenControllerProvider(int.parse(widget.worklogId!)),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Worklog synced successfully.')),
            );
        }
      }
    }

    if (widget.worklogId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Edit Work Log')),
        body: Center(
          child: Text(
            'The worklog you are trying to edit does not exist. Please try again.',
          ),
        ),
      );
    }

    final screenState = ref.watch(
      editWorklogScreenControllerProvider(int.parse(widget.worklogId!)),
    );

    ref.listen(
      editWorklogScreenControllerProvider(int.parse(widget.worklogId!)),
      (previous, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text(next.error.toString())));
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Work Log'),
        actions: [
          IconButton(icon: Icon(Icons.sync), onPressed: syncWorkLog),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              if (screenState.value != null &&
                  screenState.value!.workLog.workLogState ==
                      WorkLogStateEnum.synced) {
                final confirmed = await showConfirmationDialog(
                  context,
                  title: "Delete Work Log",
                  content:
                      "Are you sure you want to delete this work log? This will delete the work log from jira as well.",
                  confirmText: "Delete",
                  cancelText: "Cancel",
                );

                if (confirmed == true) {
                  deleteWorkLog();
                }
              } else {
                deleteWorkLog();
              }
            },
          ),
        ],
      ),
      body: screenState.when(
        data: (state) => EditWorkLogWidget(
          worklogId: int.parse(widget.worklogId!),
          taskIdController: _taskIdController,
          summaryController: _summaryController,
          descriptionController: _descriptionController,
          spentTimeController: _spentTimeController,
          startTimeController: _startTimeController,
          formKey: _formKey,
          onSave: () async {
            if (state.workLog.workLogState == WorkLogStateEnum.synced) {
              final confirmed = await showConfirmationDialog(
                context,
                title: "Update Work Log",
                content:
                    "Are you sure you want to update this work log? Any changes made will reflect in jira time logs.",
                confirmText: "Save",
                cancelText: "Cancel",
              );

              if (confirmed == true) {
                saveWorkLog();
              }
            } else {
              saveWorkLog();
            }
          },
          state: state,
        ),
        error: (error, stack) =>
            Center(child: Text('Error: ${stack.toString()}')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
