import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/cubit/payment_cubit.dart';

class PaymentMethodEmpty extends StatelessWidget {
  const PaymentMethodEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * 0.20,
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
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.m),
            Icon(Icons.credit_card, color: AppColors.primary, size: 40),
            const SizedBox(height: AppSpacing.m),
            Text(
              "No Payment Method",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              "Add a payment method to proceed",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.textHint),
            ),
            const SizedBox(height: AppSpacing.l),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.newPaymentCardPageRoute).then((_)=>BlocProvider.of<PaymentCubit>(context).getPaymentItem());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  "+ Add Payment Method",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}