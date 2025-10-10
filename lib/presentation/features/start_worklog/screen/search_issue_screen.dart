import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/presentation/features/start_worklog/widgets/search_widget.dart';

class SearchIssueScreen extends ConsumerWidget {
  const SearchIssueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchScreenController = ref.watch(
      searchIssueScreenControllerProvider,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Search Jira Issue', style: TextStyles.title)),
      body: searchScreenController.when(
        data: (state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 8,
                right: 8,
                bottom: 16,
              ),
              child: SearchWidget(),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
