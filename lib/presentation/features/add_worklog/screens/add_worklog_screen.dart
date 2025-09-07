import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/widgets/add_work_log_widget.dart';

class AddWorklogScreen extends ConsumerWidget {
  const AddWorklogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final screenState = ref.watch(addWorkLogScreenControllerProvider);

    return screenState.when(
      data: (state) {
        return Scaffold(
          appBar: AppBar(title: Text('Add Work Log')),
          body: AddWorkLogWidget(),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
