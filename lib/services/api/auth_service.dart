import '../../models/auth_response.dart';
import '../../models/user.dart';
import '../storage/secure_storage.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient apiClient;
  final SecureStorage secureStorage;

  AuthService({required this.apiClient, required this.secureStorage});

  Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final data = await apiClient.post('/auth/login', {
        'username': username,
        'password': password,
      });
      
      final auth = AuthResponse.fromJson(data as Map<String, dynamic>);
      
      await secureStorage.saveToken(auth.token);
      
      final usersData = await apiClient.get('/users') as List<dynamic>;
      final users = usersData.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
      
      final user = users.firstWhere(
        (u) => u.username == username,
        orElse: () => throw Exception('User not found'),
      );
      
      await secureStorage.saveUserId(user.id);
      return auth;
    } catch (e, stackTrace) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await secureStorage.clearAll();
  }
}


