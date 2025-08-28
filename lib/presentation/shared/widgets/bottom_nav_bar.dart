import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: "Add",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      ],
    );
  }
}
