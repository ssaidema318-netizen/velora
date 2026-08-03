import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/product_item_model.dart';
class FlashDealCard extends StatelessWidget {
  const FlashDealCard({super.key, required this.product});
  final ProductItemModel product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "-${product.discount}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.m,right: AppSpacing.m),
              child: Text(
                product.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.m,right: AppSpacing.m),
              child: Row(
                children: [
                  Text(
                    "\$${product.price}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE53935),
                    ),
                  ),
                  SizedBox(width: AppSpacing.m,),
                  Text(
                    "\$${product.oldPrice}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
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
