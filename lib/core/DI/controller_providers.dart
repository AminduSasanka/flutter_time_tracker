import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/presentation/features/settings/controller/settings_screen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';
import 'package:flutter_time_tracker/presentation/shared/controllers/navigation_controller.dart';
import 'package:flutter_time_tracker/presentation/shared/states/navigation_state.dart';

final navigationControllerProvider =
    NotifierProvider<NavigationController, NavigationState>(
      NavigationController.new,
    );

final settingsPageControllerProvider =
    AutoDisposeAsyncNotifierProvider<SettingsScreenController, SettingsScreenState>(
      SettingsScreenController.new,
    );
