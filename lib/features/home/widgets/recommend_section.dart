import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/home/widgets/recommend_card.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/product_item_model.dart';

class RecommendSection extends StatelessWidget {
  final List<ProductItemModel> productItem;

  const RecommendSection({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final recommendItems = productItem.where((e) => e.isRecommended).toList();
    return Column(
      children: [
        SectionHome(title: "Recommend For You"),
        GridView.builder(
          shrinkWrap: true,
          itemCount: recommendItems.length,

          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 252,
            crossAxisSpacing: 5,
            mainAxisSpacing: 16,
            childAspectRatio: 0.62,
          ),

          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(
                AppRoutes.producDetailsRoute,
                arguments: recommendItems[index].id,
              );
            },
            child: RecommendCard(product: recommendItems[index]),
          ),
        ),
      ],
    );
  }
}
