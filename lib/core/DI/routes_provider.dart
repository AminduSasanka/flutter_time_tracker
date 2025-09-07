import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/screens/add_worklog_screen.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/screens/edit_worklog_screen.dart';
import 'package:flutter_time_tracker/presentation/features/history/screens/history_screen.dart';
import 'package:flutter_time_tracker/presentation/features/home/screens/home_screen.dart';
import 'package:flutter_time_tracker/presentation/features/settings/screens/settings_screen.dart';
import 'package:flutter_time_tracker/presentation/shared/layouts/main_layout.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: homeRoute,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/history',
            name: historyRoute,
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/add_worklog',
            name: addWorklogRoute,
            builder: (context, state) => const AddWorklogScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/edit_worklog/:worklogId',
        name: editWorklogRoute,
        builder: (context, state) {
          final worklogId = state.pathParameters['worklogId'];

          return EditWorklogScreen(worklogId: worklogId);
        },
      ),
    ],
  );
});
