import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key, required this.subTotal});
  final int subTotal;

  static const int _shippingFee = 10;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final total = subTotal + _shippingFee;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppSpacing.m),
          _summaryRow(context, title: 'Subtotal', amount: subTotal),
          _summaryRow(context, title: 'Shipping', amount: _shippingFee),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(height: 1),
          ),
          _summaryRow(
            context,
            title: 'Total Amount',
            amount: total,
            emphasize: true,
          ),
          const SizedBox(height: AppSpacing.l),
          Row(
            children: [
              const Icon(Icons.lock_outline, size: 15, color: Colors.black45),
              const SizedBox(width: 6),
              Text(
                'Secure checkout, every time.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black45,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          SizedBox(
            width: size.width,
            
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(AppRoutes.paymentPageRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Check Out',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.surface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context, {
    required String title,
    required int amount,
    bool emphasize = false,
  }) {
    final style = emphasize
        ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
        : Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text(
            '\$$amount',
            style: emphasize
                ? style?.copyWith(color: AppColors.primary)
                : style,
          ),
        ],
      ),
    );
  }
}