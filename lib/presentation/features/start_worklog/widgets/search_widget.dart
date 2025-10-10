import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';

class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({super.key});

  @override
  ConsumerState<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String value) async {
    await ref
        .read(searchIssueScreenControllerProvider.notifier)
        .searchIssues(value);
  }

  @override
  Widget build(BuildContext context) {
    final items = [1, 3, 4, 6, 3];
    final searchTerm = _searchController.text;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchBar(
          hintText: 'Search from Jira',
          leading: Icon(Icons.search),
          onChanged: _handleSearch,
        ),
        searchTerm.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Item ${items[index]}'));
                },
              )
            : Container(),
        SizedBox(height: 24),
      ],
    );
  }
}
