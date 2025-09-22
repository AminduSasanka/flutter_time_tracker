class HomePageState {
  final Duration todayHours;
  final int todayTasksCount;
  final Duration weekHours;
  final int weekTasksCount;
  final Duration monthHours;
  final int monthTasksCount;
  final bool isError;
  final String errorMessage;

  HomePageState({
    required this.todayHours,
    required this.todayTasksCount,
    required this.weekHours,
    required this.weekTasksCount,
    required this.monthHours,
    required this.monthTasksCount,
    required this.isError,
    required this.errorMessage,
  });

  factory HomePageState.initial() {
    return HomePageState(
      todayHours: Duration.zero,
      todayTasksCount: 0,
      weekHours: Duration.zero,
      weekTasksCount: 0,
      monthHours: Duration.zero,
      monthTasksCount: 0,
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
      weekHours: weekHours ?? this.weekHours,
      weekTasksCount: weekTasksCount ?? this.weekTasksCount,
      monthHours: monthHours ?? this.monthHours,
      monthTasksCount: monthTasksCount ?? this.monthTasksCount,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
