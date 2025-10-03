import 'package:flutter/material.dart';

class StartWorklogScreen extends StatelessWidget {
  const StartWorklogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Worklog'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Start Worklog Screen'),
      ),
    );
  }
}
