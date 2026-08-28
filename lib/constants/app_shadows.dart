import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> soft = [
    BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
}
