import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/models/payment_model.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({super.key, required this.cardItem, required this.onTap});
  final PaymentModel cardItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: DecoratedBox(decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border:Border.all(color: AppColors.textSecondary)
      ),
      child: ListTile(
        leading: Image.asset("assets/images/mastercard.png",
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        ),
        title: Text("MasterCard"),
        subtitle: Text(cardItem.cardNumber),
        trailing: Icon(Icons.chevron_right_sharp),
      ),),
    );
  }
}