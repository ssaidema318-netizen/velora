import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/features/cart/widgets/product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
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
              return const Center(child: Text("Cart is empty"));
            }
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                children: [
                  ListView.separated(
                    itemCount: state.cartItem.length,
                    itemBuilder: (context, index) => ProductCard(cartItem: state.cartItem[index]),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ],
              ),
            );
          } else if (state is CartError) {
            return const Center(child: Text('Failed to load cart'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
