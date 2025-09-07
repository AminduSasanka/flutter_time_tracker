import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';

class EditWorklogScreen extends ConsumerWidget {
  final String? worklogId;

  const EditWorklogScreen({super.key, required this.worklogId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          appBar: AppBar(title: Text('Edit Work Log')),
          body: Center(child: Text('Edit Work Log Screen for ID: $worklogId')),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
