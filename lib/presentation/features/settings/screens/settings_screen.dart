import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/presentation/features/settings/widgets/jira_auth_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: EdgeInsetsGeometry.directional(
          top: 16,
          start: 8,
          end: 8,
          bottom: 16,
        ),
        child: SingleChildScrollView(
          child: Column(children: [JiraAuthWidget()]),
        ),
      ),
    );
  }
}
