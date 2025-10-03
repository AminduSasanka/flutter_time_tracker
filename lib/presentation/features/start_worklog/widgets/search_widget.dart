import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
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

  void _handleSearch(String value) {
    print('Search term: $value');
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
