import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/domain/entities/jira_issue.dart';

class SearchResultListWidget extends ConsumerWidget {
  const SearchResultListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchScreenController = ref.watch(
      searchIssueScreenControllerProvider,
    );

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
