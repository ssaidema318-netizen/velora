import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';

class HeaderPayment extends StatelessWidget {
  const HeaderPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Checkout",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md,),
                    Text("Complete Your Order",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.textHint),)
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 110,
                      child: Image.asset("assets/images/icon.png",fit: BoxFit.cover,)),
                    Text("100% Secure",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.primary,fontWeight: FontWeight.w800),)
                  ],
                )
              ],
            );
  }
}