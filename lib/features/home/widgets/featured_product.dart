import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/widgets/icon_botton.dart';

class FeaturedProduct extends StatelessWidget {
  final ProductItemModel product;

  const FeaturedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: AspectRatio(
                    aspectRatio: 0.85,
                    child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 2,
                  child: IconBotton(
                    icon: Icons.favorite_border,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm),

            Text(
              product.name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Text(
                  "⭐ ${product.rating} ",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  " (${product.reviewCount})",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              "\$${product.price}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
