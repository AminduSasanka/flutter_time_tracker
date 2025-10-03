class HomePageState {
  final Duration todayHours;
  final int todayTasksCount;
  final bool isError;
  final String errorMessage;

  HomePageState({
    required this.todayHours,
    required this.todayTasksCount,
    required this.isError,
    required this.errorMessage,
  });

  factory HomePageState.initial() {
    return HomePageState(
      todayHours: Duration.zero,
      todayTasksCount: 0,
      isError: false,
      errorMessage: '',
    );
  }

  HomePageState copyWith({
    bool? isLoading,
    Duration? todayHours,
    int? todayTasksCount,
    Duration? weekHours,
    int? weekTasksCount,
    Duration? monthHours,
    int? monthTasksCount,
    bool? isError,
    String? errorMessage,
  }) {
    return HomePageState(
      todayHours: todayHours ?? this.todayHours,
      todayTasksCount: todayTasksCount ?? this.todayTasksCount,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
