import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_router.dart';
import 'package:velora/features/bottom_navbar/custom_bottom_navbar.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/cubit/add_new_card_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CartCubit()..getCartItems()),BlocProvider(create: (_) => AddNewCardCubit()),],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomBageNavbar(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
