import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_routes.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/cubit/payment_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/cubit/add_new_card_cubit.dart';
import 'package:velora/models/payment_model.dart';

class PaymentMethodItemSheet extends StatelessWidget {
  const PaymentMethodItemSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xxl,
        left: AppSpacing.m,
        right: AppSpacing.m,
        bottom: AppSpacing.xs,
      ),
      child: BlocBuilder<AddNewCardCubit, AddNewCardState>(
        buildWhen: (previous, current) =>
            current is FetchPaymentMethodError ||
            current is FetchedPaymentMethod ||
            current is FetchingPaymentMethod,
        builder: (context, state) {
          if (state is FetchingPaymentMethod) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FetchedPaymentMethod) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Payment Method",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.m),

                  // قائمة وسائل الدفع
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.paymentCards.length,
                    itemBuilder: (context, index) {
                      PaymentModel paymentItem = state.paymentCards[index];

                      return Card(
                        color: AppColors.background,
                        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: ListTile(
                          // ✅ إصلاح الـ onTap
                          onTap: () {
                            context.read<AddNewCardCubit>().changePaymentMethod(
                              paymentItem.id,
                            );
                          },
                          leading: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 212, 212, 212),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.xs),
                              child: Image.asset(
                                "assets/images/mastercard.png",
                                height: 32,
                                width: 32,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          title: Text(paymentItem.cardNumber),
                          subtitle: Text(paymentItem.cardHolderName),
                          trailing:
                              BlocBuilder<AddNewCardCubit, AddNewCardState>(
                                buildWhen: (previous, current) =>
                                    current is PaymentMethodChosen,
                                builder: (context, cardState) {
                                  String? selectedId;
                                  if (cardState is PaymentMethodChosen) {
                                    selectedId = cardState.chosenPayment.id;
                                  }

                                  return Radio<String>(
                                    value: paymentItem.id,
                                    groupValue:
                                        selectedId, // ✅ تم ربط القيمة بشكل صحيح
                                    onChanged: (id) {
                                      if (id != null) {
                                        context
                                            .read<AddNewCardCubit>()
                                            .changePaymentMethod(id);
                                      }
                                    },
                                  );
                                },
                              ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  // زر إضافة كارت جديد
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.newPaymentCardPageRoute,
                    ),
                    child: Card(
                      color: AppColors.background,
                      child: const ListTile(
                        leading: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 212, 212, 212),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppSpacing.xs),
                            child: Icon(Icons.add),
                          ),
                        ),
                        title: Text("Add New Card"),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // زر تأكيد الدفع
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AddNewCardCubit, AddNewCardState>(
                      listenWhen: (previous, current) => current is ConfirmPaymentFailure || current is ConfirmPaymentSuccess,
                      buildWhen: (previous, current) => current is ConfirmPaymentLoading || current is ConfirmPaymentSuccess,
                      listener: (context, state) {
                        if(state is ConfirmPaymentFailure){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message))
                          );
                        } else if(state is ConfirmPaymentSuccess){
                          context.read<PaymentCubit>().getPaymentItem();
                          Navigator.of(context).pop();
                  
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is ConfirmPaymentLoading;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed:isLoading?null:(){
                            
                            BlocProvider.of<AddNewCardCubit>(context).confirmPayment();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Text(
                              "Confirm Payment",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: AppColors.surface,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FetchPaymentMethodError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
