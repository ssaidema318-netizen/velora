import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/order_product_item.dart';
import 'package:velora/models/add_to_cart_model.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.totalItems,
    required this.subTotal,
    required this.productItems,
  });
  final int totalItems;
  final int subTotal;
  final List<AddToCartModel> productItems;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 2,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            ExpansionTile(
              controlAffinity: ListTileControlAffinity.trailing,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Summary",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    "$totalItems Items",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              children: [
                GridView.builder(
                  itemCount: productItems.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      OrderProductItem(orderProduct: productItems[index]),
                ),
              ],
            ),

            const Divider(),
            ListTile(
              leading: Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.primary,
              ),
              title: Text(
                "Subtotal",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                "\$$subTotal",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.delivery_dining_sharp,
                color: AppColors.primary,
              ),
              title: Text(
                "Shipping",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                "\$10",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Text(
                "Total Amount",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                "\$${subTotal + 10}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
