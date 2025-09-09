import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/widgets/edit_work_log_widget.dart';

class EditWorklogScreen extends ConsumerWidget {
  final String? worklogId;

  const EditWorklogScreen({super.key, required this.worklogId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteWorkLog() async {
      final isDeleted = await ref
          .read(
            editWorklogScreenControllerProvider(int.parse(worklogId!)).notifier,
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
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Worklog delete failed. Please try again later.'),
              ),
            );
        }
      }
    }

    if (worklogId == null) {
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
      editWorklogScreenControllerProvider(int.parse(worklogId!)),
    );

    return screenState.when(
      data: (state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Work Log'),
            actions: [
              IconButton(icon: Icon(Icons.delete), onPressed: deleteWorkLog),
            ],
          ),
          body: EditWorkLogWidget(worklogId: int.parse(worklogId!)),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
