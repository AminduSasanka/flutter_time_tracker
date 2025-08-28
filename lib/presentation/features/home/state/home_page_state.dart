import 'package:flutter_time_tracker/core/constants/enums.dart';

class HomePageState {
  final bool isLoading;
  final HomePageScreen activeScreen;

  HomePageState(this.isLoading, this.activeScreen);

  factory HomePageState.initial() {
    return HomePageState(false, HomePageScreen.dashboard);
  }

  HomePageState copyWith(bool? isLoading, HomePageScreen? activeScreen) {
    return HomePageState(
      isLoading ?? this.isLoading,
      activeScreen ?? this.activeScreen,
    );
  }
}
