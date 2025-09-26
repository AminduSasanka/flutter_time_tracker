import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/controller_providers.dart';
import 'package:flutter_time_tracker/presentation/shared/helpers/confirmation_dialog.dart';

class EditWorkLogMenu extends ConsumerWidget {
  final BuildContext screenContext;
  final String workLogId;
  final bool isSynced;

  const EditWorkLogMenu({
    super.key,
    required this.workLogId,
    required this.screenContext,
    required this.isSynced,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteWorkLog() async {
      if (isSynced) {
        bool? isConfirmed = await showConfirmationDialog(
          context,
          title: "Delete Work Log",
          content:
              "Are you sure you want to delete this work log? Doing this will delete synced work log in jira.",
        );

        if (isConfirmed != true) return;
      }

      final isDeleted = await ref
          .read(
            editWorklogScreenControllerProvider(int.parse(workLogId)).notifier,
          )
          .deleteWorkLog();

      if (context.mounted) {
        if (isDeleted) {
          ref.invalidate(historyScreenControllerProvider);
          Navigator.pop(context);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Worklog deleted successfully')),
            );
        }
      }
    }

    void syncWorkLog() async {
      final result = await ref
          .read(
            editWorklogScreenControllerProvider(int.parse(workLogId)).notifier,
          )
          .syncWorkLog();

      if (context.mounted) {
        if (result) {
          ref.invalidate(
            editWorklogScreenControllerProvider(int.parse(workLogId)),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Worklog synced successfully.')),
            );
        }
      }
    }

    void startWorkLog() async {
      final result = await ref
          .read(
            editWorklogScreenControllerProvider(int.parse(workLogId)).notifier,
          )
          .startWorkLog();
      if (context.mounted) {
        if (result) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Worklog started successfully.')),
            );
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Failed to start worklog.')),
            );
        }
      }
    }

    return PopupMenuButton(
      initialValue: '',
      icon: Icon(Icons.more_vert),
      onSelected: (value) async {
        switch (value) {
          case 'delete':
            deleteWorkLog();
            break;
          case 'sync':
            syncWorkLog();
            break;
          case 'start':
            startWorkLog();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'start',
            child: Row(
              children: [
                Icon(Icons.play_arrow),
                SizedBox(width: 8),
                Text('Start new work log'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'sync',
            child: Row(
              children: [
                Icon(Icons.sync),
                SizedBox(width: 8),
                Text('Sync to jira'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 8),
                Text('Delete work log'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
