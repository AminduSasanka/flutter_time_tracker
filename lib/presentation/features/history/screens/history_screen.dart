import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/theme/text_styles.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/history_filters_widget.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/history_screen_menu.dart';
import 'package:flutter_time_tracker/presentation/features/history/widgets/work_log_list_widget.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref.read(historyScreenControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyScreenState = ref.watch(historyScreenControllerProvider);

    ref.listen(historyScreenControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    return historyScreenState.when(
      data: (state) {
        final Map<String, List<WorkLog>> workLogsGroupedByDate = state.workLogs;
        final List<int> selectedWorkLogIds = state.selectedWorkLogIds;

        void showFilterSheet() {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return HistoryFilterWidget();
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("History", style: TextStyles.appBarTitle),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_alt_outlined),
                onPressed: showFilterSheet,
              ),
              HistoryScreenMenu(
                isSelectionMode: selectedWorkLogIds.isNotEmpty,
                screenContext: context,
              ),
            ],
          ),
          body: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                itemCount: workLogsGroupedByDate.length,
                itemBuilder: (context, index) {
                  final date = workLogsGroupedByDate.keys.elementAt(index);
                  final workLogs = workLogsGroupedByDate[date]!;

                  return WorkLogListWidget(
                    workLogs: workLogs,
                    listTitle: date,
                    selectedWorkLogIds: selectedWorkLogIds,
                  );
                },
              ),
              if (state.isLoading!)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
