import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/features/cart/widgets/check_out.dart';
import 'package:velora/features/cart/widgets/product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          buildWhen: ((previous, current) =>
              current is CartLoading ||
              current is CartLoaded ||
              current is CartError),
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CartLoaded) {
              final cartItems = state.cartItem;

              if (cartItems.isEmpty) {
                return const _EmptyCart();
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _CartHeader(itemCount: cartItems.length),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.m),
                          child: ProductCard(cartItem: cartItems[index]),
                        ),
                        childCount: cartItems.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.l,
                        AppSpacing.m,
                        AppSpacing.l,
                        AppSpacing.l,
                      ),
                      child: BlocBuilder<CartCubit, CartState>(
                        buildWhen: (previous, current) =>
                            current is CartQuantityChanged || current is CartLoaded,
                        builder: (context, state) {
                          int subTotal = 0;
                          if (state is CartLoaded) {
                            subTotal = state.subTotal;
                          } else if (state is CartQuantityChanged) {
                            subTotal = state.subTotal;
                          }
                          return CheckOut(subTotal: subTotal);
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CartError) {
              return const Center(child: Text('Failed to load cart'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  final int itemCount;
  const _CartHeader({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.l,
        AppSpacing.l,
        AppSpacing.m,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Cart',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            itemCount == 1
                ? 'One item, ready when you are.'
                : '$itemCount items, ready when you are.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your cart is waiting',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Add something you love and it'll show up right here.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => context.read<PersistentTabController>().jumpToTab(0),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}