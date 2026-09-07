import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/home/widgets/recommend_card.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/product_item_model.dart';

class RecommendSection extends StatelessWidget {
  const RecommendSection({
    super.key,
    required this.productItem,
  });

  final List<ProductItemModel> productItem;

  @override
  Widget build(BuildContext context) {
    final recommendItems =
        productItem.where((e) => e.isRecommended).toList();

    if (recommendItems.isEmpty) {
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
              title: 'Recommend For You',
            ),

            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recommendItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                final product = recommendItems[index];

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
                  child: RecommendCard(
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
