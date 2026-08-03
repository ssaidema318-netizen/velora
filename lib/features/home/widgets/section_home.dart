import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';

class SectionHome extends StatelessWidget {
  const SectionHome({super.key, required this.title,this.icon,this.color});
  final String title;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon,color: color,size: 30,),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See All",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],);
  }
}