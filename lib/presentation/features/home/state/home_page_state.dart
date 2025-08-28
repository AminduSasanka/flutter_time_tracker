class HomePageState {
  final bool isLoading;

  HomePageState(this.isLoading);

  factory HomePageState.initial() {
    return HomePageState(false);
  }

  HomePageState copyWith(bool? isLoading) {
    return HomePageState(isLoading ?? this.isLoading);
  }
}
