import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';
import 'package:go_router/go_router.dart';

class SearchResultListWidget extends ConsumerWidget {
  const SearchResultListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchScreenController = ref.watch(
      searchIssueScreenControllerProvider,
    );

    void handleOnTap(JIraIssue jiraIssue) async {
      final isSuccess = await ref.read(searchIssueScreenControllerProvider.notifier).startWorkLog(jiraIssue);

      if (!context.mounted) {
        return;
      }

      if (isSuccess) {
        ref.invalidate(workLogControllerProvider);
        context.go(homeRoute);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Work log started successfully.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to start work log.'),
          ),
        );
      }
    }

    return searchScreenController.when(
      data: (state) {
        List<JIraIssue> searchResults = state.searchResults;

        if (searchResults.isEmpty && state.searchTerm != null) {
          return Center(child: Text('No search results found.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final searchResult = searchResults[index];

            return ListTile(
              title: Text(searchResult.key),
              subtitle: Text(searchResult.summaryText),
              onTap: () {
                handleOnTap(searchResult);
              },
            );
          },
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Container(
        margin: EdgeInsetsGeometry.directional(top: 16),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
