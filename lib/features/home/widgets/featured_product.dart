import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/favorite/cubit/favorite_cubit.dart';

class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({
    super.key,
    required this.product,
  });

  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        AppSpacing.md,
                      ),
                      child: Hero(
                        tag: product.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 0,
                    top: 8,
                    child: BlocSelector<
                        FavoriteCubit,
                        FavoriteState,
                        bool>(
                      selector: (state) {
                        return state.favoriteIds.contains(
                          product.id,
                        );
                      },
                      builder: (context, isFavorite) {
                        final isLoading = context.select<
                            FavoriteCubit,
                            bool>(
                          (cubit) =>
                              cubit.state.processingProductId ==
                              product.id,
                        );

                        if (isLoading) {
                          return const SizedBox(
                            width: 35,
                            height: 35,
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }

                        return InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            context
                                .read<FavoriteCubit>()
                                .toggleFavorite(product);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                              color: isFavorite
                                  ? AppColors.discount
                                  : AppColors.iconSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.m,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Row(
                      children: [
                        Text(
                          '⭐ ${product.rating}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        Text(
                          ' (${product.reviewCount})',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Text(
                      '\$${product.price.toStringAsFixed(0)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
