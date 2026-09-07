import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/models/categories_home_model.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({
    super.key,
    required this.categoryItem,
  });

  final CategoriesHomeModel categoryItem;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        final double imageSize = screenWidth < 600
            ? 78
            : screenWidth < 1024
                ? 88
                : 96;

        return SizedBox(
          width: imageSize + 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: categoryItem.color.withValues(alpha: 0.10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: categoryItem.imageUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    placeholder: (_, _) => const SizedBox.shrink(),
                    errorWidget: (_, _, _) {
                      return Icon(
                        Icons.image_not_supported_outlined,
                        size: imageSize * 0.30,
                        color: categoryItem.color,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              Text(
                categoryItem.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
