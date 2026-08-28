import 'package:flutter/material.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/features/home/widgets/featured_product.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/product_item_model.dart';

class FeaturedSection extends StatelessWidget {
  final List<ProductItemModel> productItem;
  const FeaturedSection({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final featuredProducts = productItem.where((e) => e.isFeatured).toList();
    return Column(
      children: [
        SectionHome(
          title: "Featured Product",
          icon: Icons.star,
          color: Colors.amber,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: featuredProducts.length,

          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 252,
            crossAxisSpacing: 5,
            mainAxisSpacing: 16,
            childAspectRatio: 0.62,
          ),

          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.producDetailsRoute,arguments: featuredProducts[index].id);
            },
            child: FeaturedProduct(product: featuredProducts[index]),
          ),
        ),
      ],
    );
  }
}
