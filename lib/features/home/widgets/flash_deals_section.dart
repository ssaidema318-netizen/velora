import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/home/widgets/flash_deal_card.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/product_item_model.dart';

class FlashDealsSection extends StatelessWidget {
  final List<ProductItemModel> productItem;
  const FlashDealsSection({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final flahDeals = productItem.where((e) => e.isFlashSale).toList();
    return Column(
      children: [
        SectionHome(title: "🔥 Flash Deals"),
        SizedBox(
          height: 320,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: flahDeals.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoutes.producDetailsRoute,
                  arguments: flahDeals[index].id,
                );
              },
              child: FlashDealCard(product: flahDeals[index]),
            ),
          ),
        ),
      ],
    );
  }
}
