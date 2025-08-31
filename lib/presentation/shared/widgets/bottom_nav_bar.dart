import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/DI/routes_provider.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/presentation/shared/states/navigation_state.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  void _onItemTapped(int idx, BuildContext context, WidgetRef ref) {
    ref.read(navigationControllerProvider.notifier).goTo(idx);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NavigationState navigationState = ref.watch(navigationControllerProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueGrey,
      unselectedItemColor: Colors.grey,
      currentIndex: navigationState.currentScreenIndex,
      onTap: (int idx) => _onItemTapped(idx, context, ref),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: "Add",
          activeIcon: Icon(Icons.add_circle),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: "History",
          activeIcon: Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
