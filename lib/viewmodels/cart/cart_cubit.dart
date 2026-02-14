import 'package:e_commerce_store/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart.dart';
import '../../services/api/cart_service.dart';
import '../../services/api/product_service.dart';
import '../auth/auth_cubit.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartService cartService;
  final ProductService productService;

  CartCubit({required this.cartService, required this.productService})
    : super(const CartState());
  Future<void> loadCart(int userId) async {
    emit(state.copyWith(status: CartStatus.loading, errorMessage: null));
    try {
      final cart = await cartService.getUserCart(userId);
      if (cart == null) {
        emit(state.copyWith(status: CartStatus.loaded, items: []));
        return;
      }

      final Map<int, Product> productsById = {}; // FIXED TYPE

      for (final item in cart.items) {
        final Product product = await productService.getProduct(
          item.productId,
        ); // ensure return type
        productsById[item.productId] = product;
      }

      emit(
        state.copyWith(
          status: CartStatus.loaded,
          items: cart.items,
          productsById: productsById,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CartStatus.error, errorMessage: e.toString()),
      );
    }
  }


  void addToCart(int productId) {
    final existing = state.items.firstWhere(
      (it) => it.productId == productId,
      orElse: () => CartItem(productId: productId, quantity: 0),
    );

    List<CartItem> updated;
    if (existing.quantity == 0) {
      updated = [...state.items, CartItem(productId: productId, quantity: 1)];
    } else {
      updated =
          state.items
              .map(
                (it) =>
                    it.productId == productId
                        ? it.copyWith(quantity: it.quantity + 1)
                        : it,
              )
              .toList();
    }
    emit(state.copyWith(items: updated));
  }

  void removeFromCart(int productId) {
    final updated =
        state.items.where((it) => it.productId != productId).toList();
    emit(state.copyWith(items: updated));
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    final updated =
        state.items
            .map(
              (it) =>
                  it.productId == productId
                      ? it.copyWith(quantity: quantity)
                      : it,
            )
            .toList();
    emit(state.copyWith(items: updated));
  }
}
