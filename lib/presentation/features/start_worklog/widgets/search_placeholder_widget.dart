import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/core/constants/route_names.dart';
import 'package:go_router/go_router.dart';

class SearchPlaceholderWidget extends StatelessWidget {
  const SearchPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsGeometry.directional(bottom: 16),
      child: SearchBar(
        hintText: 'Search from Jira',
        leading: Icon(Icons.search),
        onTap: () {
          context.push(searchIssueRoute);
        },
      ),
    );
  }
}
