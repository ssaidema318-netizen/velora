import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/features/home/product_details/cubit/product_details_cubit.dart';
import 'package:velora/features/home/product_details/widgets/information_product.dart';
import 'package:velora/models/product_item_model.dart';

class BodyProductDatails extends StatelessWidget {
  const BodyProductDatails({super.key, required this.product});
  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: double.infinity,
          color: AppColors.background,
        ),
        SizedBox(
          height: size.height * 0.45,
          width: size.width * 1,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Hero(
              tag: product.id,
              child: Image(image: AssetImage(product.imageUrl)),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.38,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                    bloc: BlocProvider.of<ProductDetailsCubit>(context),
                    buildWhen: ((previous, current) =>
                        current is QuantityCounterLoaded ||
                        current is ProdctDetailsLoaded),
                    builder: (context, state) {
                      if (state is QuantityCounterLoaded) {
                        return InformationProduct(
                          product: product,
                          value: state.value,
                          cubit: BlocProvider.of<ProductDetailsCubit>(context),
                        );
                      } else if (state is ProdctDetailsLoaded) {
                        return InformationProduct(
                          product: product,
                          value: state.productItem.quantity,
                          cubit: BlocProvider.of<ProductDetailsCubit>(context),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(height: AppSpacing.m),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.m),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * 0.09,

                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 25,
                          spreadRadius: 0,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Toal Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),),
                                SizedBox(height: AppSpacing.m),
                                BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  bloc: BlocProvider.of<ProductDetailsCubit>(
                                    context,
                                  ),
                                  buildWhen: ((previous, current) =>
                                      current is QuantityCounterLoaded ||
                                      current is ProdctDetailsLoaded),
                                  builder: (context, state) {
                                    int quantity = 1;
                                    if (state is QuantityCounterLoaded) {
                                      quantity = state.value;
                                    } else if (state is ProdctDetailsLoaded) {
                                      quantity = state.productItem.quantity;
                                    }
                                    return Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "\$",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: AppColors.primary,
                                                ),
                                          ),
                                          TextSpan(
                                            text: "${quantity * product.price}",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child:
                                BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  bloc: BlocProvider.of<ProductDetailsCubit>(
                                    context,
                                  ),
                                  buildWhen: ((previous, current) =>
                                      current is ProductAddedToCart ||
                                      current is ProductAddingToCart),
                                  builder: (context, state) {
                                    if (state is ProductAddingToCart) {
                                      return ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: AppColors.surface,
                                          shape: const StadiumBorder(),
                                        ),
                                        child:
                                            CircularProgressIndicator.adaptive(),
                                      );
                                    } else if (state is ProductAddedToCart) {
                                      return ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: AppColors.surface,
                                          shape: const StadiumBorder(),
                                        ),
                                        child: const Text("Added To Cart"),
                                      );
                                    }

                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        BlocProvider.of<ProductDetailsCubit>(
                                          context,
                                        ).addToCart(product.id);
                                        

                                        context.read<CartCubit>().refreshCart();
                                      },
                                      icon: Icon(Icons.shopping_bag_outlined),
                                      label: Text("Add Cart"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.surface,
                                        shape: const StadiumBorder(),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
