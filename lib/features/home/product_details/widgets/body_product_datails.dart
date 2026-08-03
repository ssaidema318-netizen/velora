import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/widgets/icon_botton.dart';

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
            child: Image(image: AssetImage(product.imageUrl)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
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
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: " (${product.reviewCount} reviews)",
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(color: AppColors.iconSecondary),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconBotton(
                              onPressed: () {},
                              icon: Icons.remove,
                              color: AppColors.primary,
                            ),
                            Text("1"),
                            IconBotton(
                              onPressed: () {},
                              icon: Icons.add,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.m),
                  Text(
                    "Descrption",
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
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
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
                                Text("Toal Price"),
                                SizedBox(height: AppSpacing.m),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "\$",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: AppColors.primary),
                                      ),
                                      TextSpan(
                                        text: "${product.price}",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.shopping_bag_outlined),
                              label: Text("Add Cart"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.surface,
                                shape: const StadiumBorder(),
                              ),
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
