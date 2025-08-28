import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/presentation/features/settings/state/settings_screen_state.dart';

class SettingsScreenController extends AutoDisposeNotifier<SettingsScreenState> {
  @override
  SettingsScreenState build() {
    return SettingsScreenState.initial();
  }
}