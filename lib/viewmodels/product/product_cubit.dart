import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api/product_service.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService productService;

  ProductCubit({required this.productService}) : super(const ProductState());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductStatus.loading, errorMessage: null));
    try {
      final products = await productService.getAllProducts();
      final categories = await productService.getCategories();
      emit(
        state.copyWith(
          status: ProductStatus.loaded,
          products: products,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> filterByCategory(String? category) async {
    emit(state.copyWith(status: ProductStatus.loading, selectedCategory: category, errorMessage: null));
    try {
      if (category == null || category.isEmpty) {
        final products = await productService.getAllProducts();
        emit(
          state.copyWith(
            status: ProductStatus.loaded,
            products: products,
            selectedCategory: null,
          ),
        );
      } else {
        final products = await productService.getProductsByCategory(category);
        emit(
          state.copyWith(
            status: ProductStatus.loaded,
            products: products,
            selectedCategory: category,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.error, errorMessage: e.toString()));
    }
  }
}


