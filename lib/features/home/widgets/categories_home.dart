import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/categories_home_model.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({super.key, required this.categoryItem});
  final CategoriesHomeModel categoryItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 90,
          margin: EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 176, 202, 255),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: HugeIcon(icon: categoryItem.icon),
          ),
        ),
        Text("${categoryItem.title}",style: Theme.of(context).textTheme.labelLarge,),
      ],
    );
  }
}
