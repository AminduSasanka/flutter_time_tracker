import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/outlined_action_buton.dart';
import 'package:flutter_time_tracker/core/theme/primary_button.dart';
import 'package:flutter_time_tracker/domain/entities/JiraAuth/JiraAuth.dart';

class JiraAuthWidget extends ConsumerStatefulWidget {
  const JiraAuthWidget({super.key});

  @override
  ConsumerState<JiraAuthWidget> createState() => _JiraAuthWidgetState();
}

class _JiraAuthWidgetState extends ConsumerState<JiraAuthWidget> {
  final _emailController = TextEditingController();
  final _workspaceController = TextEditingController();
  final _tokenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _workspaceController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  void _updateJiraAuth() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ref
            .read(settingsPageControllerProvider.notifier)
            .updateCreds(
              _emailController.text,
              _workspaceController.text,
              _tokenController.text,
            );

        String? error = ref.read(settingsPageControllerProvider).value?.error;

        if (error != "") {
          throw Exception("Could not update jira credentials");
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Jira credentials successfully updated')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Update Failed: ${e.toString()}')),
          );
        }
      }
    }
  }

  void _testConnection() async {}

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(settingsPageControllerProvider).isLoading;
    bool isConnectionTesting = ref
        .watch(settingsPageControllerProvider)
        .isLoading;
    JiraAuth? jiraAuth = ref
        .watch(settingsPageControllerProvider)
        .value
        ?.jiraAuth;

    if (jiraAuth != null) {
      _emailController.text = jiraAuth.email;
      _workspaceController.text = jiraAuth.workspace;
      _tokenController.text = jiraAuth.apiToken;
    }

    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jira Connection",
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
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hint: Text("johndoe@exampl.com"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your jira email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Jira Workspace URL',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _workspaceController,
                    decoration: const InputDecoration(
                      hint: Text("johndoe.atlassian.com"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your jira workspace url';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'API Token',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _tokenController,
                    decoration: const InputDecoration(
                      hint: Text("SUB@#NNE@wewebff135b2b237f"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your API token';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: "Save",
                          onPressed: _updateJiraAuth,
                          isLoading: isLoading,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedActionButton(
                          text: "Test Connection",
                          onPressed: _testConnection,
                          isLoading: isConnectionTesting,
                        ),
                      ),
                    ],
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
