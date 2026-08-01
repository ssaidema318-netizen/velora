import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/bottom_navbar/custom_bottom_navbar.dart';
import 'package:velora/features/home/product_details/cubit/prodct_details_cubit.dart';
import 'package:velora/features/home/product_details/product_details_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.customBottomRoute:
        return MaterialPageRoute(builder: (_) => const CustomBageNavbar());
      case AppRoutes.producDetailsRoute:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProdctDetailsCubit();
              cubit.getProductDetails(productId);
              return cubit;
            },
            child: ProductDetailsPage(productId: productId),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No Route defined for ${settings.name}")),
          ),
        );
    }
  }
}
