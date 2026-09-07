import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page/widgets/order_product_item.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    // تحديد أبعاد الشاشة لتطبيق التصميم التكيفي (Breakpoints)
    final bool isMobile = screenWidth < 600;
    final double paddingValue = isMobile ? AppSpacing.m : AppSpacing.l;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Material(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(30),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // قسم تفاصيل الطلب المتمدد
              ExpansionTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Order Summary",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 18 : 22,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$totalItems Items",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // تحديد عرض كل عنصر داخل الـ Grid بحسب العرض المتاح
                      double maxExtent = isMobile ? 180 : 240;
                      return GridView.builder(
                        itemCount: productItems.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: maxExtent,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            OrderProductItem(orderProduct: productItems[index]),
                      );
                    },
                  ),
                ],
              ),

              const Divider(),

              // Subtotal Row
              ListTile(
                dense: isMobile,
                leading: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.primary,
                  size: isMobile ? 22 : 28,
                ),
                title: Text(
                  "Subtotal",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 16 : 18,
                      ),
                ),
                trailing: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "\$$subTotal",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile ? 16 : 18,
                        ),
                  ),
                ),
              ),

              const Divider(),

              // Shipping Row
              ListTile(
                dense: isMobile,
                leading: Icon(
                  Icons.delivery_dining_sharp,
                  color: AppColors.primary,
                  size: isMobile ? 22 : 28,
                ),
                title: Text(
                  "Shipping",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 16 : 18,
                      ),
                ),
                trailing: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "\$10",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile ? 16 : 18,
                        ),
                  ),
                ),
              ),

              const Divider(),

              // Total Amount Row (تم استبدال leading بـ title لمنع الـ Overflow)
              ListTile(
                dense: isMobile,
                title: Text(
                  "Total Amount",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 17 : 20,
                      ),
                ),
                trailing: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "\$${subTotal + 10}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: isMobile ? 18 : 22,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}