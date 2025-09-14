import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/confirmation_dialog.dart';

class HistoryScreenMenu extends ConsumerWidget {
  final bool isSelectionMode;
  final BuildContext screenContext;

  const HistoryScreenMenu({
    super.key,
    required this.isSelectionMode,
    required this.screenContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleBulkDelete() async {
      bool isDeletionSuccess = await ref
          .read(historyScreenControllerProvider.notifier)
          .deleteSelectedWorkLogs();

      if (!screenContext.mounted) return;

      if (isDeletionSuccess) {
        ScaffoldMessenger.of(screenContext).showSnackBar(
          SnackBar(content: Text('Selected items deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(screenContext).showSnackBar(
          SnackBar(content: Text('Failed to delete selected items')),
        );
      }
    }

    void handleBulkSync() async {
      bool isSyncSuccess = await ref
          .read(historyScreenControllerProvider.notifier)
          .syncSelectedWorkLogs();

      if (!screenContext.mounted) return;

      if (isSyncSuccess) {
        ScaffoldMessenger.of(screenContext).showSnackBar(
          SnackBar(content: Text('Selected items synced successfully')),
        );
      } else {
        ScaffoldMessenger.of(screenContext).showSnackBar(
          SnackBar(content: Text('Failed to sync selected items')),
        );
      }
    }

    return PopupMenuButton(
      initialValue: '',
      icon: Icon(Icons.more_vert),
      onSelected: (value) async {
        switch (value) {
          case 'delete':
            bool? isConfirmed = await showConfirmationDialog(
              context,
              title: "Delete Work Logs",
              content:
                  "Are you sure you want to delete selected work logs? Doing this will delete synced work logs in jira.",
            );

            if (isConfirmed != true) return;

            handleBulkDelete();
            break;
          case 'sync':
            handleBulkSync();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'delete',
            enabled: isSelectionMode,
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 8),
                Text('Delete selected items'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'sync',
            enabled: isSelectionMode,
            child: Row(
              children: [
                Icon(Icons.sync),
                SizedBox(width: 8),
                Text('Sync selected items'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
