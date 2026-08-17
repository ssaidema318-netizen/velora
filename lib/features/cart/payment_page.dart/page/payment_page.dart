import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/cubit/payment_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/cubit/add_new_card_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/delivery_address.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/header_payment.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/order_summary.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/payment_method_empty.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/payment_method_item.dart';
import 'package:velora/features/cart/payment_page.dart/widgets/payment_method_item_sheet.dart';
import 'package:velora/models/address_model.dart';
import 'package:velora/models/payment_model.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  Widget buildPaymentMethod(PaymentModel? chosenCard, BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (chosenCard != null) {
      return PaymentMethodItem(
        cardItem: chosenCard,
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (_) => SizedBox(
              height: size.height * 0.6,
              width: size.width * 1,
              child: Builder(
                builder: (context) {
                  final cubit = context.read<AddNewCardCubit>();
                  cubit.fetchPaymentMethod();
                  return BlocProvider.value(
                    value: cubit,
                    child: const PaymentMethodItemSheet(),
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      return PaymentMethodEmpty();
    }
  }

  Widget buildShippingAddress(AddressModel? addressCard, BuildContext context) {
    if (addressCard != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "assets/images/map_address.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressCard.countery,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                "${addressCard.countery},${addressCard.city}",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.textHint),
              ),
            ],
          ),
        ],
      );
    } else {
      return DeliveryAddress();
    }
  }

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
                        subtitle: "Edit",
                        onPressed: () async {
                          // PaymentPage
                          final result = await Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.chooseAddressPageRoute);

                          if (result == true) {
                            context.read<PaymentCubit>().getPaymentItem();
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.m),
                      buildShippingAddress(state.chosenAddress, context),
                      const SizedBox(height: AppSpacing.l),
                      OrderSummary(
                        totalItems: state.totalItems,
                        subTotal: state.subTotale,
                        productItems: state.paymentItem,
                      ),
                      const SizedBox(height: AppSpacing.l),
                      header(context, title: "Payment Method"),
                      const SizedBox(height: AppSpacing.m),
                      buildPaymentMethod(state.chosenPayment, context),
                      const SizedBox(height: AppSpacing.l),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed:state.chosenAddress==null||state.chosenPayment==null?null:() {
                            
                          },
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
                                      "\$${state.subTotale + 10} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColors.surface,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt,
                                      color: AppColors.surface,
                                      size: 50,
                                    ),
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
    String? subtitle,
    VoidCallback? onPressed,
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

        if (subtitle != null)
          TextButton(
            onPressed: onPressed,
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
