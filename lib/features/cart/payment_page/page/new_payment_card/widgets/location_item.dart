import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/address_model.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({super.key, required this.onTap, required this.location,this.color=AppColors.iconSecondary});
  final VoidCallback onTap;
  final AddressModel location;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.m),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: color),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.background,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          location.countery,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        Text(
                                          location.city,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 43,
                                      backgroundColor: color,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage("assets/images/map_address.png"),
                                        ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
    );
  }
}