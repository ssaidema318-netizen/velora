import 'package:flutter/material.dart';

import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/core/responsive.dart';
import 'package:velora/models/product_item_model.dart';
import 'package:velora/widgets/icon_botton.dart';

class InformationProduct extends StatelessWidget {
  const InformationProduct({
    super.key,
    required this.product,
    required this.value,
    required this.cubit,
  });

  final ProductItemModel product;
  final int value;
  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          return _MobileInformation(
            product: product,
            value: value,
            cubit: cubit,
          );
        }

        return _DesktopInformation(
          product: product,
          value: value,
          cubit: cubit,
        );
      },
    );
  }
}

class _DesktopInformation extends StatelessWidget {
  const _DesktopInformation({
    required this.product,
    required this.value,
    required this.cubit,
  });

  final ProductItemModel product;
  final int value;
  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ProductInfo(
            product: product,
          ),
        ),

        const SizedBox(width: AppSpacing.l),

        _QuantitySelector(
          value: value,
          cubit: cubit,
          productId: product.id,
        ),
      ],
    );
  }
}

class _MobileInformation extends StatelessWidget {
  const _MobileInformation({
    required this.product,
    required this.value,
    required this.cubit,
  });

  final ProductItemModel product;
  final int value;
  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductInfo(
          product: product,
        ),

        const SizedBox(height: AppSpacing.m),

        Align(
          alignment: Alignment.centerLeft,
          child: _QuantitySelector(
            value: value,
            cubit: cubit,
            productId: product.id,
          ),
        ),
      ],
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({
    required this.product,
  });

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: context.sp(26),
              ),
        ),

        const SizedBox(height: AppSpacing.m),

        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            Text(
              '⭐ ${product.rating}',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              '(${product.reviewCount} reviews)',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.iconSecondary,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({
    required this.value,
    required this.cubit,
    required this.productId,
  });

  final int value;
  final dynamic cubit;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      constraints: const BoxConstraints(
        minWidth: 130,
        maxWidth: 150,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBotton(
            onPressed: () {
              cubit.decrementCounter(productId);
            },
            icon: Icons.remove,
            color: AppColors.primary,
          ),

          Flexible(
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          IconBotton(
            onPressed: () {
              cubit.incrementCounter(productId);
            },
            icon: Icons.add,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
