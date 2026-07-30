import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/widgets/icon_botton.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/profile.jfif"),
              ),
              const SizedBox(width: AppSpacing.l),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hallo,",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Said  ",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.waving_hand_rounded,color: Colors.amber,size: 30,)
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Text(
                    "What are you looking for today?",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.textHint),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconBotton(onPressed: () {}, icon: Icons.notifications_none_outlined),
              SizedBox(width: AppSpacing.l,),
              IconBotton(icon: Icons.shopping_cart_outlined, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
