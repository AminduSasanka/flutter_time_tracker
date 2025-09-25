import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/presentation/features/history/state/history_screen_state.dart';
import 'package:intl/intl.dart';

class HistoryFilterWidget extends ConsumerStatefulWidget {
  const HistoryFilterWidget({super.key});

  @override
  ConsumerState<HistoryFilterWidget> createState() =>
      _HistoryFilterWidgetState();
}

class _HistoryFilterWidgetState extends ConsumerState<HistoryFilterWidget> {
  final List<WorkLogStateEnum> selectedWorkLogStates = [];
  bool prioritizeLocalSelectedWorkLogState = false;

  @override
  Widget build(BuildContext context) {
    final stateProvider = ref.watch(historyScreenControllerProvider);
    final TextEditingController dateController = TextEditingController();
    final TextEditingController taskKeyInputController =
        TextEditingController();

    Future<void> pickDateTime(HistoryScreenState state) async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: state.filterStartDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (date == null) return;

      dateController.text = DateFormat('yyyy-MM-dd').format(date);
    }

    void applyFilters() {
      ref
          .read(historyScreenControllerProvider.notifier)
          .filterWorkLogs(
            startDate: dateController.text != ""
                ? DateTime.parse(dateController.text)
                : null,
            taskKey: taskKeyInputController.text,
            worklogStates: selectedWorkLogStates,
          );

      Navigator.pop(context);

      if (context.mounted) {
        if (ref.read(historyScreenControllerProvider).hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ref.read(historyScreenControllerProvider).error.toString(),
              ),
            ),
          );
        }
      }
    }

    void clearFilters() {
      ref
          .read(historyScreenControllerProvider.notifier)
          .filterWorkLogs(startDate: null, taskKey: null, worklogStates: null);

      taskKeyInputController.text = "";
      dateController.text = "";

      Navigator.pop(context);

      if (context.mounted) {
        if (ref.read(historyScreenControllerProvider).hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ref.read(historyScreenControllerProvider).error.toString(),
              ),
            ),
          );
        }
      }
    }

    return stateProvider.when(
      data: (HistoryScreenState state) {
        dateController.text = state.filterStartDate != null
            ? DateFormat('yyyy-MM-dd').format(state.filterStartDate!)
            : "";
        taskKeyInputController.text = state.filterTaskKey ?? "";

        if (!prioritizeLocalSelectedWorkLogState) {
          selectedWorkLogStates.addAll(state.filterStates ?? []);
        }

        bool isWorkLogStateSelected(WorkLogStateEnum workLogState) {
          if (prioritizeLocalSelectedWorkLogState) {
            return selectedWorkLogStates.contains(workLogState);
          } else {
            return state.filterStates?.contains(workLogState) ?? false;
          }
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text("Work Log State"),
                SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children:
                      [WorkLogStateEnum.synced, WorkLogStateEnum.completed].map(
                        (WorkLogStateEnum workLogState) {
                          return FilterChip(
                            showCheckmark: false,
                            padding: const EdgeInsets.all(2),
                            selectedColor: Theme.of(context).primaryColor,
                            label: Text(workLogState.name),
                            selected: isWorkLogStateSelected(workLogState),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  prioritizeLocalSelectedWorkLogState = true;
                                  selectedWorkLogStates.add(workLogState);
                                } else {
                                  prioritizeLocalSelectedWorkLogState = true;
                                  selectedWorkLogStates.remove(workLogState);
                                }
                              });
                            },
                          );
                        },
                      ).toList(),
                ),
                SizedBox(height: 16),
                Text("Date"),
                SizedBox(height: 4),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select Date",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    pickDateTime(state);
                  },
                ),
                SizedBox(height: 16),
                Text("Task Key"),
                SizedBox(height: 4),
                TextField(
                  controller: taskKeyInputController,
                  decoration: InputDecoration(
                    hintText: "NPR-739",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: clearFilters,
                      child: Text("Clear Filters"),
                    ),
                    FilledButton(
                      onPressed: applyFilters,
                      child: Text("Apply Filters"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
