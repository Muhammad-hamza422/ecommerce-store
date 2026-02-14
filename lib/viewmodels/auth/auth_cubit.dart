import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api/auth_service.dart';
import '../../services/storage/secure_storage.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final SecureStorage secureStorage;

  AuthCubit({
    required this.authService,
    required this.secureStorage,
  }) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    final token = await secureStorage.getToken();
    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(status: AuthStatus.authenticated, isAuthenticated: true, token: token));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated, isAuthenticated: false, token: null));
    }
  }

  Future<void> login({required String username, required String password}) async {
    
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    
    try {
      final auth = await authService.login(username: username, password: password);
      
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          isAuthenticated: true,
          token: auth.token,
          errorMessage: null,
        ),
      );
    } catch (e, stackTrace) {
      
      String errorMsg = 'Login failed. Please check your credentials.';
      if (e.toString().contains('Invalid credentials') || 
          e.toString().contains('401')) {
        errorMsg = 'Invalid username or password.';
      } else if (e.toString().contains('Exception:')) {
        errorMsg = e.toString().replaceFirst('Exception: ', '');
      }
      
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isAuthenticated: false,
          token: null,
          errorMessage: errorMsg,
        ),
      );
    }
  }

  Future<void> logout() async {
    
    await authService.logout();
    
    emit(const AuthState(
      status: AuthStatus.unauthenticated, 
      isAuthenticated: false,
      token: null,
      errorMessage: null,
    ));
  }
}


