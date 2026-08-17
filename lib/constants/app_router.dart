import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/bottom_navbar/custom_bottom_navbar.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/choose_address_page.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/cubit/add_new_card_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/new_payment_card_page.dart';
import 'package:velora/features/cart/payment_page.dart/page/payment_page.dart';
import 'package:velora/features/home/product_details/cubit/product_details_cubit.dart';
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
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(productId);
              return cubit;
            },
            child: ProductDetailsPage(productId: productId),
          ),
        );
      case AppRoutes.paymentPageRoute:
        return MaterialPageRoute(builder: (_)=>PaymentPage());
      case AppRoutes.newPaymentCardPageRoute:
        return MaterialPageRoute(builder: (_)=>BlocProvider(
          create: (context) =>AddNewCardCubit(),
          child:NewPaymentCardPage(),
        )
        
        );
      case AppRoutes.chooseAddressPageRoute:
        return MaterialPageRoute(builder: (_)=>ChooseAddressPage()
        
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
