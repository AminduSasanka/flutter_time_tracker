import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';

class AddWorklogScreen extends StatefulWidget {
  const AddWorklogScreen({super.key});

  @override
  State<AddWorklogScreen> createState() => _AddWorklogScreenState();
}

class _AddWorklogScreenState extends State<AddWorklogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Worklog", style: TextStyles.appBarTitle),
        backgroundColor: Colors.white,
      ),
      body: Center(child: Text("Add Worklog page")),
    );
  }
}
