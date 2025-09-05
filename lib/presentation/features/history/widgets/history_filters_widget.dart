import 'package:flutter/material.dart';

class HistoryFilterWidget extends StatefulWidget {
  const HistoryFilterWidget({super.key});

  @override
  State<HistoryFilterWidget> createState() => _HistoryFilterWidgetState();
}

class _HistoryFilterWidgetState extends State<HistoryFilterWidget> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _taskKeyInputController = TextEditingController();
  DateTime? selectedDateTime;

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      selectedDateTime = DateTime(date.year, date.month, date.day);
      _controller.text = selectedDateTime!.toIso8601String();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 8,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text("Date"),
          SizedBox(height: 4),
          TextField(
            controller: _controller,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Select Date",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: _pickDateTime,
          ),
          SizedBox(height: 16),
          Text("Task Key"),
          SizedBox(height: 4),
          TextField(
            controller: _taskKeyInputController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "NPR-739",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text("Clear Filters"),
                onPressed: () {},
              ),
              FilledButton(
                child: Text("Apply Filters"),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 42),
        ],
      ),
    );
  }
}
