import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/add_to_cart_model.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({super.key, required this.orderProduct});
  final AddToCartModel orderProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.backgroundSecondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              // height: 130,
              width: double.infinity,
              child: Image.asset(orderProduct.imageUrl,fit: BoxFit.contain,),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      "Quantity",
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      "×${orderProduct.quantity}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
  ],
),

const SizedBox(height: 8),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      "Total Price",
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      "\$${orderProduct.totalPrice}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
          ],
        ),
      ),
    );
  }
}
