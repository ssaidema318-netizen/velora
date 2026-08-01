import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/bottom_navbar/custom_bottom_navbar.dart';
import 'package:velora/features/home/product_details/product_details_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.customBottomRoute:
        return MaterialPageRoute(builder: (_) => const CustomBageNavbar());
      case AppRoutes.producDetailsRoute:
        return MaterialPageRoute(builder: (_) => const ProductDetailsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No Route defined for ${settings.name}")),
          ),
        );
    }
  }
}
