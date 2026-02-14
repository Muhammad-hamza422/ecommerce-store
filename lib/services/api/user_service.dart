import '../../models/user.dart';
import '../storage/secure_storage.dart';
import 'api_client.dart';

class UserService {
  final ApiClient apiClient;

  UserService({required this.apiClient});

  Future<User> getUserById(int id) async {
    final data = await apiClient.get('/users/$id') as Map<String, dynamic>;
    return User.fromJson(data);
  }

  Future<User?> getCurrentUser(SecureStorage storage) async {
    final id = await storage.getUserId();
    if (id == null) return null;
    return getUserById(id);
  }
}


