import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/widgets/icon_botton.dart';

class InformationProduct extends StatelessWidget {
  const InformationProduct({super.key, required this.product, required this.value,required this.cubit});
  final ProductItemModel product;
  final int value;
  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            SizedBox(height: AppSpacing.m),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "⭐ ${product.rating}   ",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: " (${product.reviewCount} reviews)",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.iconSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBotton(
                  onPressed: () =>cubit.decrementCounter(product.id),
                  icon: Icons.remove,
                  color: AppColors.primary,
                ),
                Text(value.toString()),
                IconBotton(
                  onPressed: ()=> cubit.incrementCounter(product.id),
                  icon: Icons.add,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
