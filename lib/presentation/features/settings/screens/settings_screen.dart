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
        padding: EdgeInsetsGeometry.directional(start: 15, end: 15),
        child: Column(
          children: [
            JiraAuthWidget()
          ],
        ),
      ),
    );
  }
}
