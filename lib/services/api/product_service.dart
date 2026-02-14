import '../../models/product.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient apiClient;

  ProductService({required this.apiClient});

  Future<List<Product>> getAllProducts() async {
    final data = await apiClient.get('/products') as List<dynamic>;
    return data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<String>> getCategories() async {
    final data = await apiClient.get('/products/categories') as List<dynamic>;
    return data.map((e) => e.toString()).toList();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await apiClient.get('/products/category/$category') as List<dynamic>;
    return data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Product> getProduct(int id) async {
    final data = await apiClient.get('/products/$id') as Map<String, dynamic>;
    return Product.fromJson(data);
  }
}


