class SettingsScreenState {
  final bool isLoading;
  final String apiToken;
  final String email;
  final String workspaceUrl;

  SettingsScreenState(
    this.isLoading,
    this.apiToken,
    this.email,
    this.workspaceUrl,
  );

  factory SettingsScreenState.initial() {
    return SettingsScreenState(true, "", "", "");
  }

  SettingsScreenState copyWith(
    bool? isLoading,
    String? apiToken,
    String? email,
    String? workspaceUrl,
  ) {
    return SettingsScreenState(
      isLoading ?? this.isLoading,
      apiToken ?? this.apiToken,
      email ?? this.email,
      workspaceUrl ?? this.workspaceUrl,
    );
  }
}
