import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/models/add_to_cart_model.dart';
import 'package:velora/widgets/icon_botton.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.cartItem});
  final AddToCartModel cartItem;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: size.height * 0.18,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(30),
      ),

      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                cartItem.imageUrl,
                width: size.width * 0.25,
                height: size.height * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.m),
                  Text(
                    "⭐ ${cartItem.rating} (${cartItem.reviewCount})",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: AppSpacing.l),
                  BlocBuilder<CartCubit, CartState>(
                    bloc: BlocProvider.of<CartCubit>(context),
                    buildWhen: (previous, current) =>
                        current is CartQuantityChanged &&
                        current.updatedItem.productId == cartItem.productId,
                    builder: (context, state) {
                      int totalPrice = cartItem.totalPrice;

                      if (state is CartQuantityChanged &&
                          state.updatedItem.productId == cartItem.productId) {
                        totalPrice = state.updatedItem.totalPrice;
                      }

                      return Text(
                        "\$${totalPrice}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSpacing.xl),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconBotton(
                            onPressed: () => BlocProvider.of<CartCubit>(
                              context,
                            ).decrementCounter(cartItem),
                            icon: Icons.remove,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: AppSpacing.m),
                          BlocBuilder<CartCubit, CartState>(
                            buildWhen: (previous, current) =>
                                current is CartQuantityChanged ||
                                current is CartLoaded,
                            builder: (context, state) {
                              int quantity = cartItem.quantity;

                              if (state is CartQuantityChanged &&
                                  state.updatedItem.productId == cartItem.productId) {
                                quantity = state.updatedItem.quantity;
                              }

                              return Text(
                                quantity.toString(),
                                style: Theme.of(context).textTheme.labelLarge,
                              );
                            },
                          ),
                          SizedBox(width: AppSpacing.m),
                          IconBotton(
                            onPressed: () => BlocProvider.of<CartCubit>(
                              context,
                            ).incrementCounter(cartItem),
                            icon: Icons.add,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      Spacer(),
                      IconBotton(
                        onPressed: () {
                          BlocProvider.of<CartCubit>(
                            context,
                          ).removeItem(cartItem);
                        },
                        icon: Icons.delete,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
