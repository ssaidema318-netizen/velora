import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/cubit/cart_cubit.dart';
import 'package:velora/features/favorite/cubit/favorite_cubit.dart';
import 'package:velora/models/product_item_model.dart';

class CardFavorite extends StatefulWidget {
  final ProductItemModel product;
  const CardFavorite({super.key, required this.product});

  @override
  State<CardFavorite> createState() => _CardFavoriteState();
}

class _CardFavoriteState extends State<CardFavorite>
    with SingleTickerProviderStateMixin {
  final GlobalKey _imageKey = GlobalKey(); // 🔥 هنمسك بيه مكان الصورة

  void _flyToCart() {
    final renderBox =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final startOffset = renderBox.localToGlobal(Offset.zero);
    final imageSize = renderBox.size;

    final screenSize = MediaQuery.of(context).size;
    // 🔥 تقريب مكان أيقونة الكارت في الـ bottom nav (التاب التالت من 5)
    final targetOffset = Offset(
      (screenSize.width / 5) * 2.5 - 14,
      screenSize.height - 40,
    );

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    final positionAnim = Tween<Offset>(
      begin: startOffset,
      end: targetOffset,
    ).chain(CurveTween(curve: Curves.easeInCubic)).animate(controller);
    final scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.15,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    final opacityAnim = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.6, 1.0)),
    );

    entry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Positioned(
              left: positionAnim.value.dx,
              top: positionAnim.value.dy,
              child: Opacity(
                opacity: opacityAnim.value,
                child: Transform.scale(
                  scale: scaleAnim.value,
                  child: SizedBox(
                    width: imageSize.width,
                    height: imageSize.height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.product.imageUrl, // 🔥 asset مش network
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) =>
                            Container(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    overlay.insert(entry);
    controller.forward().whenComplete(() {
      entry.remove();
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: ClipRRect(
                      key: _imageKey, // 🔥 هنا بنمسك مكان الصورة الأصلية
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.8),
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () {
                        context.read<FavoriteCubit>().toggleFavorite(product);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.m,
                0,
                AppSpacing.m,
                AppSpacing.m,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '⭐ ${product.rating}  (${product.reviewCount})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$${product.price.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _flyToCart(); // 🔥 الأنيميشن
                            context.read<CartCubit>().addItemFromProduct(
                              product,
                            );
                          }, // 🔥 كان فاضي، دلوقتي شغال
                          icon: const Icon(
                            Icons.shopping_cart_rounded,
                            color: AppColors.surface,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
