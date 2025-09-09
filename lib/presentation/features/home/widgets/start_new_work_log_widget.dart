import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/primary_button.dart';

class StartNewWorkLogWidget extends ConsumerStatefulWidget {
  const StartNewWorkLogWidget({super.key});

  @override
  ConsumerState<StartNewWorkLogWidget> createState() => _StartNewWorkLogWidgetState();
}

class _StartNewWorkLogWidgetState extends ConsumerState<StartNewWorkLogWidget> {
  final _taskIdController = TextEditingController();
  final _summaryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _startWorkLog() {
    if (_formKey.currentState!.validate()) {
      ref.read(workLogControllerProvider.notifier).startNewWorkLog(
        _taskIdController.text,
        _summaryController.text,
        _descriptionController.text,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid work log. Please check your inputs.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What are you working on",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
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
                    controller: _taskIdController,
                    decoration: const InputDecoration(
                      hintText:"ABC-2314",
                    ),
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
                    controller: _summaryController,
                    decoration: const InputDecoration(
                      hintText: "Team meeting",
                    ),
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
                      isLoading: false
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
