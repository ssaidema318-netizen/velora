import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/features/home/product_details/cubit/prodct_details_cubit.dart';
import 'package:velora/features/home/product_details/widgets/app_bar_widget.dart';
import 'package:velora/features/home/product_details/widgets/body_product_datails.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProdctDetailsCubit, ProdctDetailsState>(
      builder: (context, state) {
        if (state is ProdctDetailsLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProdctDetailsLoaded) {
          final product = state.productItem;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBarWidget() as PreferredSizeWidget,
            body: BodyProductDatails(product: product),
            
          );
        } else if (state is ProdctDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return Scaffold(body: Center(child: Text("Some Thing went wrong")));
        }
      },
    );
  }
}
