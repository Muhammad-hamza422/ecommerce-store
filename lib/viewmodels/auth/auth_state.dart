enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final bool isAuthenticated;
  final String? token;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.isAuthenticated = false,
    this.token,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isAuthenticated,
    String? token,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      errorMessage: errorMessage,
    );
  }
}


