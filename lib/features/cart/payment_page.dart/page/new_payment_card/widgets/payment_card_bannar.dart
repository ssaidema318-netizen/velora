import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/widgets/card_info.dart';


class PaymentCardBanner extends StatelessWidget {
  const PaymentCardBanner({
    super.key,
    required this.cardHolderName,
    required this.lastFourDigits,
    required this.expiryDate,
  });

  final String cardHolderName;
  final String lastFourDigits;
  final String expiryDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.primary,
      ),
      child: Stack(
        children: [
          // الخلفية الدائرية الأولى
          Positioned(
            top: -70,
            right: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryDark.withValues(alpha: 0.45),
              ),
            ),
          ),

          // الخلفية الدائرية الثانية
          Positioned(
            bottom: -100,
            left: -45,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryDark.withValues(alpha: 0.35),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "VELORA",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 30,
                        ),

                        const SizedBox(width: 8),

                        Icon(
                          Icons.contactless,
                          color: Colors.white,
                          size: 27,
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Card Number
                Text(
                  "•••• •••• •••• $lastFourDigits",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),

                const Spacer(),

                // Bottom information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    CardInfo(
                      title: "CARD HOLDER",
                      value: cardHolderName,
                    ),

                    CardInfo(
                      title: "VALID THRU",
                      value: expiryDate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}