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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                cartItem.imageUrl,
                width: size.width * 0.22,
                height: size.width * 0.22,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "⭐ ${cartItem.rating} (${cartItem.reviewCount})",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black45,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                            "\$$totalPrice",
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                          );
                        },
                      ),
                      IconBotton(
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context).removeItem(cartItem);
                        },
                        icon: Icons.delete_outline,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconBotton(
                          onPressed: () => BlocProvider.of<CartCubit>(context)
                              .decrementCounter(cartItem),
                          icon: Icons.remove,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          width: 28,
                          child: BlocConsumer<CartCubit, CartState>(
                            listenWhen: (previous, current) =>
                                current is CartMaxQuantityReached,
                            listener: (context, state) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No more stock available"),
                                ),
                              );
                            },
                            buildWhen: (previous, current) =>
                                current is CartQuantityChanged ||
                                current is CartLoaded,
                            builder: (context, state) {
                              int quantity = cartItem.quantity;

                              if (state is CartQuantityChanged &&
                                  state.updatedItem.productId ==
                                      cartItem.productId) {
                                quantity = state.updatedItem.quantity;
                              }

                              return Text(
                                quantity.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelLarge,
                              );
                            },
                          ),
                        ),
                        IconBotton(
                          onPressed: () => BlocProvider.of<CartCubit>(context)
                              .incrementCounter(cartItem),
                          icon: Icons.add,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
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