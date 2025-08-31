import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/screens/add_worklog_screen.dart';
import 'package:flutter_time_tracker/presentation/features/history/screens/history_screen.dart';
import 'package:flutter_time_tracker/presentation/features/home/screens/home_screen.dart';
import 'package:flutter_time_tracker/presentation/shared/widgets/bottom_nav_bar.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  static const mainWidgetList = [
    HomeScreen(),
    AddWorklogScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentScreenIndex = ref.watch(navigationControllerProvider).currentScreenIndex;
    Widget currentScreen = mainWidgetList[currentScreenIndex];

    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
