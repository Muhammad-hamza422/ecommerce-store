import '../../models/cart.dart';
import 'api_client.dart';

class CartService {
  final ApiClient apiClient;

  CartService({required this.apiClient});

  Future<Cart?> getUserCart(int userId) async {
    final data = await apiClient.get('/carts/user/$userId') as List<dynamic>;
    // final data = await apiClient.get('/carts') as List<dynamic>;

    if (data.isEmpty) return null;
    return Cart.fromJson(data.last as Map<String, dynamic>);
  }
}
