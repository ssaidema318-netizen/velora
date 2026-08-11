import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/cubit/payment_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/delivery_address.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/header_payment.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/order_summary.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/payment_method.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = PaymentCubit();
        cubit.getPaymentItem();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          buildWhen: (previous, current) =>
              current is PaymentLoaded ||
              current is PaymentLoading ||
              current is PaymentError,
          builder: (context, state) {
            if (state is PaymentLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is PaymentLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Column(
                    children: [
                      HeaderPayment(),
                      const SizedBox(height: AppSpacing.l),
                      header(
                        context,
                        title: "Delivery Address",
                        subtitle: "+ Add Now",
                      ),
                      const SizedBox(height: AppSpacing.m),
                      DeliveryAddress(),
                      const SizedBox(height: AppSpacing.l),
                      OrderSummary(totalItems: state.totalItems, subTotal: state.subTotale, productItems: state.paymentItem,),
                      const SizedBox(height: AppSpacing.l),
                      header(
                        context,
                        title: "Payment Method",
                        subtitle: "+ Add Now",
                      ),
                      const SizedBox(height: AppSpacing.m),
                      PaymentMethod(),
                      const SizedBox(height: AppSpacing.l),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: null,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Place Order",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: AppColors.surface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$${state.subTotale+10} ",
                                      style: Theme.of(context).textTheme.titleLarge!
                                          .copyWith(
                                            color: AppColors.surface,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Icon(Icons.arrow_right_alt,color: AppColors.surface,size: 50,)
                                  ],
                                  
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is PaymentError) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget header(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    
    );
  }
}
