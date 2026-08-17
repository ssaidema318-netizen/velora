import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/cubit/add_new_card_cubit.dart';

import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/widgets/app_text_form_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/widgets/payment_card_bannar.dart';

class NewPaymentCardPage extends StatefulWidget {
  const NewPaymentCardPage({super.key});

  @override
  State<NewPaymentCardPage> createState() => _NewPaymentCardPageState();
}

class _NewPaymentCardPageState extends State<NewPaymentCardPage> {
  final formKey = GlobalKey<FormState>();
  final cardHolderController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final expiryDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Add New Card"))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Your card",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.m),
                Text(
                  "Securely save your card for faster checkout.",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.textHint),
                ),
                const SizedBox(height: AppSpacing.m),
                PaymentCardBanner(
                  cardHolderName: cardHolderController.text.isEmpty
                      ? "SAID EMAM"
                      : cardHolderController.text.toUpperCase(),
                  lastFourDigits: cardNumberController.text.isEmpty
                      ? "4582"
                      : cardNumberController.text.substring(
                          cardNumberController.text.length - 4,
                        ),
                  expiryDate: expiryDateController.text.isEmpty
                      ? "12/28"
                      : expiryDateController.text,
                ),
                const SizedBox(height: AppSpacing.m),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextFormField(
                        controller: cardHolderController,
                        label: "Cardholder Name",
                        hintText: 'Enter cardholder name',
                        textInputAction: TextInputAction.next,
                        obscureText: false,

                        validator: 'Cardholder name is required',
                        suffixIcon: Icons.person,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextFormField(
                        controller: cardNumberController,
                        label: "Card Number",
                        hintText: '1234 5678 9012 3456',
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        validator: 'Cardholder number is required',
                        keyboardType: TextInputType.number,
                        inputFormatters: [cardNumberFormatter],
                        suffixIcon: Icons.credit_card,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              controller: expiryDateController,
                              label: "Expiry Date",
                              hintText: "MM/YY",
                              textInputAction: TextInputAction.next,

                              obscureText: false,
                              validator: "Enter a valid expiry date",
                              keyboardType: TextInputType.number,
                              inputFormatters: [expiryDateFormatter],
                              suffixIcon: Icons.date_range,
                            ),
                          ),

                          const SizedBox(width: AppSpacing.m),

                          Expanded(
                            child: AppTextFormField(
                              controller: cvvController,
                              label: "CVV",
                              hintText: "123",
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              validator: "Enter a valid CVV",
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              suffixIcon: Icons.confirmation_num_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        "🛡️ Your card information is securely encrypted.",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.textHint),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Divider(),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        height: 60,
                        width: double.infinity,

                        child: BlocConsumer<AddNewCardCubit, AddNewCardState>(
                          buildWhen: (previous, current) =>
                              current is AddNewCardLoading ||
                              current is AddNewCardSuccess,
                          listenWhen: (previous, current) =>
                              current is AddNewCardSuccess ||
                              current is AddNewCardFailure,
                          bloc: BlocProvider.of<AddNewCardCubit>(context),
                          listener: (context, state) {
                            if (state is AddNewCardSuccess) {
                              Navigator.pop(context);
                            } else if (state is AddNewCardFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AddNewCardLoading) {
                              return ElevatedButton(
                                onPressed: null,

                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AddNewCardCubit>(
                                    context,
                                  ).addNewCard(
                                    cardHolderController.text,
                                    cardNumberController.text,
                                    expiryDateController.text,
                                    cvvController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                              ),
                              child: Text(
                                "Add Card",
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      color: AppColors.surface,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
