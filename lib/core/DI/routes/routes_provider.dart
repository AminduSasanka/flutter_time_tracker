import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/presentation/features/home/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        name: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
