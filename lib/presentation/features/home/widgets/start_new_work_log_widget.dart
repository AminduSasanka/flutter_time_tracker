import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/theme/outlined_action_buton.dart';
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
                      hint: Text("ABC-2314"),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hint: Text("Discussed about next CR"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                      text: "Start",
                      onPressed: () {},
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
