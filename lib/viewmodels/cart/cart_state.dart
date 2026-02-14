import '../../models/cart.dart';
import '../../models/product.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState {
  final CartStatus status;
  final List<CartItem> items;
  final Map<int, Product> productsById;
  final String? errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.productsById = const {},
    this.errorMessage,
  });

  double get total {
    double sum = 0;
    for (final item in items) {
      final product = productsById[item.productId];
      if (product != null) {
        sum += product.price * item.quantity;
      }
    }
    return sum;
  }

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    Map<int, Product>? productsById,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      productsById: productsById ?? this.productsById,
      errorMessage: errorMessage,
    );
  }
}


