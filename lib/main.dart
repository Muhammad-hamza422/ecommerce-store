import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'services/api/api_client.dart';
import 'services/api/auth_service.dart';
import 'services/api/product_service.dart';
import 'services/api/cart_service.dart';
import 'services/api/user_service.dart';
import 'services/storage/secure_storage.dart';
import 'viewmodels/auth/auth_cubit.dart';
import 'viewmodels/product/product_cubit.dart';
import 'viewmodels/cart/cart_cubit.dart';
import 'viewmodels/profile/profile_cubit.dart';
import 'viewmodels/theme/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();
  final secureStorage = SecureStorage();
  final authService = AuthService(apiClient: apiClient, secureStorage: secureStorage);
  final productService = ProductService(apiClient: apiClient);
  final cartService = CartService(apiClient: apiClient);
  final userService = UserService(apiClient: apiClient);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) {
            return AuthCubit(authService: authService, secureStorage: secureStorage)..checkAuthStatus();
          },
        ),
        BlocProvider<ProductCubit>(
          create: (_) => ProductCubit(productService: productService)..loadProducts(),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(cartService: cartService, productService: productService),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(userService: userService, secureStorage: secureStorage),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

