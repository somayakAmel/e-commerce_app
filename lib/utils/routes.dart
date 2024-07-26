import 'package:e_commerce/features/products_management/model/product.dart';
import 'package:e_commerce/features/products_management/view/screens/home_screen.dart';
import 'package:e_commerce/features/products_management/view/screens/product_details.dart';
import 'package:e_commerce/features/user_management/view/screens/register.dart';
import 'package:e_commerce/features/user_management/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../features/products_management/view/screens/favorite_screen.dart';
import '../features/products_management/view/screens/main_screen.dart';
import '../features/shopping_cart/view/screens/cart_screen.dart';
import '../features/user_management/view/screens/login.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String register = '/register';
  static const String main = '/main';
  static const String productDetail = '/productDetail';
  static const String cartView = '/cartView';
  static const String favorite = '/favorite';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case productDetail:
        Product product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetails(
                  product: product,
                ));
      case cartView:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
