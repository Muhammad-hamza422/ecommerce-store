import 'package:e_commerce_store/viewmodels/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/constants/app_constants.dart';
import 'views/auth/login_view.dart';
import 'views/home/home_view.dart';
import 'views/home/product_detail_view.dart';
import 'views/cart/cart_view.dart';
import 'views/profile/profile_view.dart';
import 'models/product.dart';
import 'viewmodels/auth/auth_cubit.dart';
import 'viewmodels/theme/theme_cubit.dart';
import 'viewmodels/theme/theme_state.dart';
import 'utils/themes/app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _buildAuthHome(AuthState state) {
    if (state.status == AuthStatus.initial ||
        state.status == AuthStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.isAuthenticated && state.status == AuthStatus.authenticated) {
      return const HomeView();
    }

    return const LoginView();
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.routeLogin:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case AppConstants.routeHome:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppConstants.routeCart:
        return MaterialPageRoute(builder: (_) => const CartView());
      case AppConstants.routeProfile:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case AppConstants.routeProductDetail:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailView(product: product),
        );
      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return MaterialApp(
              key: ValueKey(authState.isAuthenticated),
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeState.mode,
              onGenerateRoute: _onGenerateRoute,
              home: _buildAuthHome(authState),
            );
          },
        );
      },
    );
  }
}
