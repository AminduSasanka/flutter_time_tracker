import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/bottom_nav_bar.dart';

class AddWorklogScreen extends StatefulWidget {
  const AddWorklogScreen({super.key});

  @override
  State<AddWorklogScreen> createState() => _AddWorklogScreenState();
}

class _AddWorklogScreenState extends State<AddWorklogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Worklog")),
      body: Center(child: Text("Add Worklog page")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
