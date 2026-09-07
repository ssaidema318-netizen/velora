import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/home/widgets/flash_deal_card.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/product_item_model.dart';

class FlashDealsSection extends StatelessWidget {
  const FlashDealsSection({
    super.key,
    required this.productItem,
  });

  final List<ProductItemModel> productItem;

  @override
  Widget build(BuildContext context) {
    final flashDeals =
        productItem.where((e) => e.isFlashSale).toList();

    if (flashDeals.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final double cardWidth = width < 600
            ? 175
            : width < 1024
                ? 200
                : 220;

        final double sectionHeight = width < 600
            ? 305
            : width < 1024
                ? 325
                : 345;

        return Column(
          children: [
            const SectionHome(
              title: '🔥 Flash Deals',
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: sectionHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: flashDeals.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final product = flashDeals[index];

                  return SizedBox(
                    width: cardWidth,
                    child: InkWell(
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
                      child: FlashDealCard(
                        product: product,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
