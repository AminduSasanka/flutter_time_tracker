import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/presentation/features/settings/controller/settings_screen_controller.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';

final settingsPageControllerProvider =
    AutoDisposeNotifierProvider<SettingsScreenController, SettingsScreenState>(
      SettingsScreenController.new,
    );
