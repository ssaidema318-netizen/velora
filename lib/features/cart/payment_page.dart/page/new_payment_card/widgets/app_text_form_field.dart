import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType,
    required this.textInputAction,
    required this.obscureText,
    this.inputFormatters, required this.validator, required this.suffixIcon,
  });
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String validator;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.m,),
        Container(
           decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.15),
        blurRadius: 8,
        spreadRadius: 1,
      ),
    ],
  ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              suffixIcon:Icon(suffixIcon,color:AppColors.textHint ,) ,
              hintText: hintText,
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.textHint, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.border, width: 4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.primaryLight, width: 4),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.error, width: 4),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.error, width: 4),
              ),
              contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.l,
            vertical: AppSpacing.l,
          ),
          
            ),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            
            validator: (value) {
              if(value==null|| value.trim().isEmpty){
                return validator;
              }
              return null;
            },
          ),
        ),
        
      ],
    );
  }
}
