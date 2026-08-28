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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
  height: 100,
  width: 100,
  margin: const EdgeInsets.all(AppSpacing.m),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: categoryItem.color.withValues(alpha: 0.10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.18),
        blurRadius: 20,
        spreadRadius: 1,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: CachedNetworkImage(
      imageUrl: categoryItem.imageUrl,
      fit: BoxFit.cover,

      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: categoryItem.color,
        ),
      ),

      errorWidget: (context, url, error) => Icon(
        Icons.image_not_supported_outlined,
        color: categoryItem.color,
      ),
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
    );
  }
}