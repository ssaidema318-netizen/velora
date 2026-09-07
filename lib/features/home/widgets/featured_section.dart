import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/home/widgets/featured_product.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/product_item_model.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({
    super.key,
    required this.productItem,
  });

  final List<ProductItemModel> productItem;

  @override
  Widget build(BuildContext context) {
    final featuredProducts =
        productItem.where((e) => e.isFeatured).toList();

    if (featuredProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final int columns = _getColumns(width);

        final double aspectRatio = width < 600
            ? 0.68
            : width < 900
                ? 0.70
                : 0.72;

        return Column(
          children: [
            const SectionHome(
              title: 'Featured Product',
              icon: Icons.star,
              color: Colors.amber,
            ),

            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: featuredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                final product = featuredProducts[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed(
                      AppRoutes.producDetailsRoute,
                      arguments: product.id,
                    );
                  },
                  child: FeaturedProduct(
                    product: product,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  int _getColumns(double width) {
    if (width < 600) return 2;
    if (width < 900) return 3;
    if (width < 1200) return 4;
    return 5;
  }
}
