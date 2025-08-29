class NavigationState {
  final int currentScreenIndex;

  NavigationState({required this.currentScreenIndex});

  NavigationState copyWith(int newIndex) {
    return NavigationState(currentScreenIndex: currentScreenIndex ?? newIndex);
  }
}
