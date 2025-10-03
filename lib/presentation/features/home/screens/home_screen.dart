import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/current_work_log_widget.dart';
import 'package:flutter_time_tracker/presentation/features/home/widgets/home_summary_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final workLogState = ref.watch(workLogControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyles.appBarTitle),
        actions: [
          IconButton(
            onPressed: () {
              context.push(settingsRoute);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: workLogState.when(
        data: (state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsGeometry.directional(
                start: 8,
                end: 8,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentWorkLogWidget(),
                  Text("Today", style: TextStyles.subTitle),
                  const SizedBox(height: 8),
                  HomeSummaryWidget(),
                ],
              ),
            ),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
