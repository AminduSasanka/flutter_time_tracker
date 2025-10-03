import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/primary_button.dart';

class StartNewWorkLogWidget extends ConsumerStatefulWidget {
  const StartNewWorkLogWidget({super.key});

  @override
  ConsumerState<StartNewWorkLogWidget> createState() =>
      _StartNewWorkLogWidgetState();
}

class _StartNewWorkLogWidgetState extends ConsumerState<StartNewWorkLogWidget> {
  final _taskIdController = TextEditingController();
  final _summaryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _taskIdController.dispose();
    _summaryController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startWorkLog() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(workLogControllerProvider.notifier)
          .startNewWorkLog(
            _taskIdController.text,
            _summaryController.text,
            _descriptionController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(
          hintText: 'Search from Jira',
          leading: Icon(Icons.search),
          onChanged: (value) {
            print('Search input: $value');
          },
          onSubmitted: (value) {
            print('Search submitted: $value');
          },
        ),
        SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Task ID'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _taskIdController,
                decoration: const InputDecoration(hintText: "ABC-2314"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your jira task ID';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Summary'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(hintText: "Team meeting"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your work log summary';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: "Start",
                onPressed: _startWorkLog,
                isLoading: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
