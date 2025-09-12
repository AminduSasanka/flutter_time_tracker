import 'package:flutter/material.dart';

class TextFormFieldInputLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const TextFormFieldInputLabel({
    super.key,
    required this.label,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final textWidgets = <Widget>[];

    textWidgets.add(
      Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );

    if (isRequired) {
      textWidgets.add(SizedBox(width: 4));
      textWidgets.add(
        Text('*', style: TextStyle(fontSize: 16, color: Colors.red)),
      );
    }

    return Row(mainAxisSize: MainAxisSize.max, children: textWidgets);
  }
}
