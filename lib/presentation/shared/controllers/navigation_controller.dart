import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/presentation/shared/state/navigation_state.dart';

class NavigationController extends Notifier<NavigationState> {
  @override
  NavigationState build() {
    return NavigationState(currentScreenIndex: 0);
  }

  void goTo(int index) {
    state = state.copyWith(index);
  }
}