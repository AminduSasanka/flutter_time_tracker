import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/controller/add_worklog_screen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/add_worklog/state/add_worklog_screen_state.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/controller/edit_worklog_screen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/edit_worklog/state/edit_worklog_screen_state.dart';
import 'package:flutter_time_tracker/presentation/features/history/controller/history_screen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/history/state/history_screen_state.dart';
import 'package:flutter_time_tracker/presentation/features/home/controller/home_page_controller.dart';
import 'package:flutter_time_tracker/presentation/features/home/controller/work_log_controller.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/home_page_state.dart';
import 'package:flutter_time_tracker/presentation/features/home/state/work_log_state.dart';
import 'package:flutter_time_tracker/presentation/features/settings/controller/settings_screen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';
import 'package:flutter_time_tracker/presentation/features/start_worklog/controller/search_issue_screeen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/start_worklog/state/search_issue_screen_state.dart';
import 'package:flutter_time_tracker/presentation/shared/controllers/navigation_controller.dart';
import 'package:flutter_time_tracker/presentation/shared/states/navigation_state.dart';

final navigationControllerProvider =
    NotifierProvider<NavigationController, NavigationState>(
      NavigationController.new,
    );

final settingsPageControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      SettingsScreenController,
      SettingsScreenState
    >(SettingsScreenController.new);

final workLogControllerProvider =
    AutoDisposeAsyncNotifierProvider<WorkLogController, WorkLogState>(
      WorkLogController.new,
    );

final historyScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      HistoryScreenController,
      HistoryScreenState
    >(HistoryScreenController.new);

final editWorklogScreenControllerProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      EditWorklogScreenController,
      EditWorklogScreenState,
      int
    >(EditWorklogScreenController.new);

final addWorkLogScreenControllerProvider =
    AutoDisposeNotifierProvider<
      AddWorklogScreenController,
      AddWorklogScreenState
    >(AddWorklogScreenController.new);

final homePageControllerProvider =
    AsyncNotifierProvider<HomePageController, HomePageState>(
      HomePageController.new,
    );

final searchIssueScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      SearchIssueScreenController,
      SearchIssueScreenState
    >(SearchIssueScreenController.new);
