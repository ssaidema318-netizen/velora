import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/cubit/payment_cubit.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});
  

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.m),
            Icon(Icons.location_pin, color: AppColors.primary, size: 40),
            const SizedBox(height: AppSpacing.m),
            Text(
              "No Delivery Address",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              "Add an address to deliver your arder",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.textHint),
            ),
            const SizedBox(height: AppSpacing.l),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                onPressed: ()async{// PaymentPage
final result = await Navigator.of(context).pushNamed(AppRoutes.chooseAddressPageRoute);

if (result == true) {
  context.read<PaymentCubit>().getPaymentItem();
}},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  "+ Add Delivery Address",
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
