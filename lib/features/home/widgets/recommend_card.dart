import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/widgets/icon_botton.dart';

class RecommendCard extends StatelessWidget {
  final ProductItemModel product;

  const RecommendCard({super.key, required this.product});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: IconBotton(
                  icon: Icons.favorite_border,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "⭐ ${product.rating}",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),

                Text("\$${product.price}",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.primary,fontWeight: FontWeight.w900),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
