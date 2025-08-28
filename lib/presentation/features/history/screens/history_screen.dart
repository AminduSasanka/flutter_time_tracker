import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/bottom_nav_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Center(child: Text("History page")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
