import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodels/cart/cart_cubit.dart';
import '../../viewmodels/cart/cart_state.dart';
import '../../viewmodels/profile/profile_cubit.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_widget.dart' as app_error;
import '../../widgets/empty_state.dart';
import '../../utils/helpers/price_formatter.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool _initialLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialLoaded) {
      _initialLoaded = true;
      _loadInitialCart(context);
    }
  }

  Future<void> _loadInitialCart(BuildContext context) async {
    final profileCubit = context.read<ProfileCubit>();
    await profileCubit.loadProfile();
    final user = profileCubit.state.user;
    if (user != null) {
      await context.read<CartCubit>().loadCart(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.loading && state.items.isEmpty) {
            return const LoadingIndicator(message: 'Loading cart...');
          }

          if (state.status == CartStatus.error) {
            return app_error.AppErrorWidget(
              message: state.errorMessage ?? 'Failed to load cart',
              onRetry: () => _loadInitialCart(context),
            );
          }

          if (state.items.isEmpty) {
            return const EmptyState(
              title: 'Your cart is empty',
              message: 'Browse products and add them to your cart.',
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    final product = state.productsById[item.productId];
                    if (product == null) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      leading: Image.network(
                        product.image,
                        width: 48,
                        height: 48,
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(PriceFormatter.format(product.price)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed:
                                    () => context
                                        .read<CartCubit>()
                                        .updateQuantity(
                                          item.productId,
                                          item.quantity - 1,
                                        ),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed:
                                    () => context
                                        .read<CartCubit>()
                                        .updateQuantity(
                                          item.productId,
                                          item.quantity + 1,
                                        ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed:
                            () => context.read<CartCubit>().removeFromCart(
                              item.productId,
                            ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: state.items.length,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color ?? colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      PriceFormatter.format(state.total),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '(Local only)',
                      style: TextStyle(
                        color: colorScheme.tertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
