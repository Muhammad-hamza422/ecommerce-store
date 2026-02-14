import '../../models/product.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState {
  static const Object _selectedCategorySentinel = Object();

  final ProductStatus status;
  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedCategory,
    this.errorMessage,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    List<String>? categories,
    Object? selectedCategory = _selectedCategorySentinel,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategory:
          selectedCategory == _selectedCategorySentinel
              ? this.selectedCategory
              : selectedCategory as String?,
      errorMessage: errorMessage,
    );
  }
}


