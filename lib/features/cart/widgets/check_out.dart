import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key, required this.subTotal});
  final int subTotal;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(children: [
       totalAndSubtotla(context, title: "Suptoltal", amount: subTotal),
       totalAndSubtotla(context, title: "Shipping", amount: 10),
       totalAndSubtotla(context, title: "Total Amount", amount:subTotal+10),
       const SizedBox(height: 40,),
       SizedBox(
        width: size.width-40,
        height: size.height*0.06,
        child: ElevatedButton(onPressed: (){}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface
        ),
        child: Text("Check Out",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.surface),)))

    ],);
  }

  Widget totalAndSubtotla(BuildContext context, {required String title, required int amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          Text('${amount.toString()}', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

}

