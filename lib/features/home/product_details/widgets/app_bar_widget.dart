import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/widgets/icon_botton.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconBotton(
              icon: Icons.keyboard_arrow_left_rounded,
              onPressed: () => Navigator.pop(context),
              color: AppColors.primary,
            ),
            Text("Velora", style: Theme.of(context).textTheme.headlineMedium),
            IconBotton(
              icon: Icons.favorite_border_sharp,
              onPressed: () {},
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
