import 'package:e_commerce/features/products_management/view/screens/home_screen.dart';
import 'package:e_commerce/features/user_management/view/screens/register.dart';
import 'package:flutter/material.dart';

import '../features/user_management/view/screens/login.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // case productDetail:
      //   var productId = settings.arguments as int;
      //   return MaterialPageRoute(builder: (_) => ProductDetailView(productId: productId));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
