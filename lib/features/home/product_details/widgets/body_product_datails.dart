import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/home/product_details/cubit/product_details_cubit.dart';
import 'package:velora/features/home/product_details/widgets/information_product.dart';
import 'package:velora/models/product_item_model.dart';

class BodyProductDatails extends StatelessWidget {
  const BodyProductDatails({
    super.key,
    required this.product,
  });

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 700) {
          return _MobileLayout(product: product);
        }

        return _LargeLayout(product: product);
      },
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProductImage(product: product, height: 360),
          _ProductContent(product: product, borderRadius: 45),
        ],
      ),
    );
  }
}

class _LargeLayout extends StatelessWidget {
  const _LargeLayout({required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 700),
      color: AppColors.background,
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: _ProductImage(product: product, height: 600),
            ),
          ),
          const SizedBox(width: AppSpacing.l),
          Expanded(
            flex: 5,
            child: _ProductContent(product: product, borderRadius: 45),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.product,
    required this.height,
  });

  final ProductItemModel product;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Hero(
          tag: product.id,
          child: Image(
            image: AssetImage(product.imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _ProductContent extends StatelessWidget {
  const _ProductContent({
    required this.product,
    required this.borderRadius,
  });

  final ProductItemModel product;
  final double borderRadius;

  int _getQuantity(ProductDetailsState state) {
    if (state is QuantityCounterLoaded) {
      return state.value;
    } else if (state is QuantityMaxReached) {
      return state.value;
    } else if (state is ProdctDetailsLoaded) {
      return state.productItem.quantity;
    }
    return product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
            listenWhen: (previous, current) {
              return current is QuantityMaxReached || current is ProductAddedToCart;
            },
            listener: (context, state) {
              if (state is QuantityMaxReached) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No more stock available')),
                );
              } else if (state is ProductAddedToCart) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Successfully added to cart')),
                );
              }
            },
            buildWhen: (previous, current) {
              return current is QuantityCounterLoaded ||
                  current is QuantityMaxReached ||
                  current is ProdctDetailsLoaded;
            },
            builder: (context, state) {
              final quantity = _getQuantity(state);

              return InformationProduct(
                product: product,
                value: quantity,
                cubit: context.read<ProductDetailsCubit>(),
              );
            },
          ),
          const SizedBox(height: AppSpacing.l),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            product.description,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _BottomCartSection(product: product),
        ],
      ),
    );
  }
}

class _BottomCartSection extends StatelessWidget {
  const _BottomCartSection({required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 400;

        if (isSmall) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TotalPrice(product: product),
              const SizedBox(height: AppSpacing.m),
              _AddToCartButton(product: product),
            ],
          );
        }

        return Container(
          constraints: const BoxConstraints(minHeight: 90),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(child: _TotalPrice(product: product)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _AddToCartButton(product: product)),
            ],
          ),
        );
      },
    );
  }
}

class _TotalPrice extends StatelessWidget {
  const _TotalPrice({required this.product});

  final ProductItemModel product;

  int _getQuantity(ProductDetailsState state) {
    if (state is QuantityCounterLoaded) {
      return state.value;
    } else if (state is QuantityMaxReached) {
      return state.value;
    } else if (state is ProdctDetailsLoaded) {
      return state.productItem.quantity;
    }
    return product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Total Price',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          buildWhen: (previous, current) {
            return current is QuantityCounterLoaded ||
                current is QuantityMaxReached ||
                current is ProdctDetailsLoaded;
          },
          builder: (context, state) {
            final quantity = _getQuantity(state);
            final total = quantity * product.price;

            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '\$',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  TextSpan(
                    text: total.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) {
        return current is ProductAddedToCart || current is ProductAddingToCart;
      },
      builder: (context, state) {
        if (state is ProductAddingToCart) {
          return ElevatedButton(
            onPressed: null,
            style: _buttonStyle(),
            child: const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (state is ProductAddedToCart) {
          return ElevatedButton(
            onPressed: null,
            style: _buttonStyle(),
            child: const Text('Added To Cart'),
          );
        }

        return ElevatedButton.icon(
          onPressed: () {
            context.read<ProductDetailsCubit>().addToCart(product.id);
          },
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Text('Add Cart'),
          style: _buttonStyle(),
        );
      },
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(0, 54),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surface,
      shape: const StadiumBorder(),
    );
  }
}