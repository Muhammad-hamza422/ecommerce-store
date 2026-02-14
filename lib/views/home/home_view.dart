import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodels/product/product_cubit.dart';
import '../../viewmodels/product/product_state.dart';
import '../../viewmodels/cart/cart_cubit.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_widget.dart' as app_error;
import '../../widgets/empty_state.dart';
import '../../widgets/product_card.dart';
import '../../utils/constants/app_constants.dart';
import '../../models/product.dart';
import '../../viewmodels/theme/theme_cubit.dart';
import '../../viewmodels/theme/theme_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _refresh(BuildContext context) async {
    await context.read<ProductCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed:
                () => Navigator.pushNamed(context, AppConstants.routeProfile),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(
                  themeState.isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed:
                () => Navigator.pushNamed(context, AppConstants.routeCart),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading && state.products.isEmpty) {
            return const LoadingIndicator(message: 'Loading products...');
          }

          if (state.status == ProductStatus.error) {
            return app_error.AppErrorWidget(
              message: state.errorMessage ?? 'Failed to load products',
              onRetry: () => context.read<ProductCubit>().loadProducts(),
            );
          }

          if (state.products.isEmpty) {
            return const EmptyState(
              title: 'No products found',
              message: 'Pull down to refresh or try again later.',
            );
          }

          final categories = ['All', ...state.categories];
          final filteredProducts =
              _searchQuery.trim().isEmpty
                  ? state.products
                  : state.products.where((product) {
                    final q = _searchQuery.toLowerCase();
                    return product.title.toLowerCase().contains(q) ||
                        product.category.toLowerCase().contains(q);
                  }).toList();

          return RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                  child: Material(
                    elevation: 2,
                    shadowColor: Colors.black.withValues(alpha: 0.08),
                    color:
                        Theme.of(context).cardTheme.color ??
                        colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search by product or category',
                        hintStyle: TextStyle(color: colorScheme.tertiary),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: colorScheme.primary,
                        ),
                        suffixIcon:
                            _searchQuery.isNotEmpty
                                ? IconButton(
                                  icon: Icon(
                                    Icons.cancel_rounded,
                                    color: colorScheme.tertiary,
                                  ),
                                  onPressed: () {
                                    _searchCtrl.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                                : null,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSelected =
                          (cat == 'All' &&
                              (state.selectedCategory == null ||
                                  state.selectedCategory!.isEmpty)) ||
                          state.selectedCategory == cat;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        labelStyle: TextStyle(
                          color:
                              isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                        selectedColor: colorScheme.primary,
                        backgroundColor: colorScheme.secondary,
                        checkmarkColor: colorScheme.onPrimary,
                        onSelected: (_) {
                          if (cat == 'All') {
                            context.read<ProductCubit>().filterByCategory(null);
                          } else {
                            context.read<ProductCubit>().filterByCategory(cat);
                          }
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: categories.length,
                  ),
                ),
                Expanded(
                  child:
                      filteredProducts.isEmpty
                          ? const EmptyState(
                            title: 'No matching products',
                            message:
                                'Try a different product name or category.',
                          )
                          : GridView.builder(
                            padding: const EdgeInsets.all(12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return ProductCard(
                                product: product,
                                onTap: () => _openDetail(context, product),
                                onAddToCart:
                                    () => context.read<CartCubit>().addToCart(
                                      product.id,
                                    ),
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, Product product) {
    Navigator.pushNamed(
      context,
      AppConstants.routeProductDetail,
      arguments: product,
    );
  }
}
