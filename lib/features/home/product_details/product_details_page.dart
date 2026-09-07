import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/features/favorite/cubit/favorite_cubit.dart';
import 'package:velora/features/home/product_details/cubit/product_details_cubit.dart';
import 'package:velora/features/home/product_details/widgets/body_product_datails.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) {
        return current is ProdctDetailsError ||
            current is ProdctDetailsLoaded ||
            current is ProdctDetailsLoading;
      },
      builder: (context, state) {
        if (state is ProdctDetailsLoading) {
          return SafeArea(
            child: const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            ),
          );
        }

        if (state is ProdctDetailsError) {
          return _ErrorView(message: state.message);
        }

        if (state is ProdctDetailsLoaded) {
          return _LoadedProductView(product: state.productItem);
        }

        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}

class _LoadedProductView extends StatelessWidget {
  const _LoadedProductView({required this.product});

  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: AppColors.iconSecondary,
            ),
          ),
          actions: [
            BlocSelector<FavoriteCubit, FavoriteState, bool>(
              selector: (state) {
                return state.favoriteIds.contains(product.id);
              },
              builder: (context, isFavorite) {
                final isLoading = context.select<FavoriteCubit, bool>(
                  (cubit) => cubit.state.processingProductId == product.id,
                );

                if (isLoading) {
                  return const SizedBox(
                    width: 35,
                    height: 35,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    context.read<FavoriteCubit>().toggleFavorite(product);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: isFavorite
                          ? AppColors.discount
                          : AppColors.iconSecondary,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: BodyProductDatails(product: product),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 52,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Unable to load product',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
