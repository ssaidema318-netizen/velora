import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/widgets/app_text_form_field.dart';

class NewPaymentCardPage extends StatefulWidget {
  const NewPaymentCardPage({super.key});

  @override
  State<NewPaymentCardPage> createState() => _NewPaymentCardPageState();
}

class _NewPaymentCardPageState extends State<NewPaymentCardPage> {
  final cardHolderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Add New Card"))),
      body: SafeArea(
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
              Form(
                child: Column(
                  children: [
                    AppTextFormField(
  controller: cardHolderController,
  label: "Cardholder Name",
  hintText: "Enter cardholder name",

  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return "Cardholder name is required";
    }

    return null;
  },
  
),
const SizedBox(height: AppSpacing.m),
                    AppTextFormField(
  controller: cardHolderController,
  label: "Card Number",
  hintText: "Enter cardholder name",
  keyboardType: TextInputType.number,

  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return "Cardholder name is required";
    }

    return null;
  },
),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
