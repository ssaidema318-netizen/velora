import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';

class IconBotton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const IconBotton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: 
      BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.border
      ),
      child: IconButton(onPressed: onPressed, icon:Icon(icon,size: 30,) ),
    );
  }
}