import 'package:flutter/material.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/widgets/icon_botton.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isMobile = width < 600;

        final double avatarRadius = isMobile ? 27 : 34;

        return SizedBox(
          height: isMobile ? 78 : 92,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: const AssetImage(
                        'assets/images/profile.jfif',
                      ),
                    ),

                    SizedBox(
                      width: isMobile
                          ? AppSpacing.sm
                          : AppSpacing.l,
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Hallo, ',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: isMobile ? 18 : 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),

                              Flexible(
                                child: Text(
                                  'Said',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: isMobile ? 18 : 22,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),

                              const SizedBox(width: 4),

                              Text(
                                '👋',
                                style: TextStyle(
                                  fontSize: isMobile ? 20 : 25,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.xs),

                          Text(
                            'What are you looking for today?',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: AppColors.textHint,
                                  fontSize: isMobile ? 11 : 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconBotton(
                    onPressed: () {},
                    icon: Icons.notifications_none_outlined,
                  ),

                  SizedBox(
                    width: isMobile
                        ? AppSpacing.xs
                        : AppSpacing.sm,
                  ),

                  IconBotton(
                    icon: Icons.shopping_cart_outlined,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
