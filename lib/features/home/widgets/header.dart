import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/profile/cubit/profile_cubit.dart';
import 'package:velora/widgets/icon_botton.dart';

class Header extends StatelessWidget {
  final nameUser;
  const Header({super.key, required this.nameUser});

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
                    GestureDetector(
                      onTap: () => context
                          .read<PersistentTabController>()
                          .jumpToTab(4),
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen: (previous, current) =>
                            previous.userData?.photoUrl != current.userData?.photoUrl,
                        builder: (context, profileState) {
                          final photoUrl = profileState.userData?.photoUrl;

                          return CustomPaint(
                            painter: _RingPainter(color: AppColors.primary),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: avatarRadius,
                                backgroundColor: AppColors.primary,
                                backgroundImage: photoUrl != null
                                    ? NetworkImage(photoUrl)
                                    : const AssetImage('assets/images/profile.jfif')
                                        as ImageProvider,
                              ),
                            ),
                          );
                        },
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
                                  '$nameUser',
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
                    onPressed: () {context.read<PersistentTabController>().jumpToTab(2);},
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

class _RingPainter extends CustomPainter {
  final Color color;
  const _RingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    // 🔥 قوس بيغطي 300 درجة بدل دائرة كاملة، بيبدأ من فوق شمال
    // شوية ويسيب فجوة صغيرة — ده اللي بيدي شكل مختلف عن أي دايرة عادية
    const startAngle = -2.6;
    const sweepAngle = 5.2;

    canvas.drawArc(rect.deflate(1), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.color != color;
}