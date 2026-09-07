import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/favorite/cubit/favorite_cubit.dart';
import 'package:velora/features/favorite/widgets/card_favorite.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // حساب عدد الأعمدة بناءً على عرض الشاشة
    int crossAxisCount = 2; // الافتراضي للموبايل
    if (screenWidth > 1200) {
      crossAxisCount = 5; // شاشات الكومبيوتر
    } else if (screenWidth > 800) {
      crossAxisCount = 4; // التابلت الكبير
    } else if (screenWidth > 600) {
      crossAxisCount = 3; // التابلت الصغير أو الموبايل بالعرض
    } else if (screenWidth < 360) {
      crossAxisCount = 1; // الموبايلات الصغير جداً (مثل iPhone SE)
    }

    // تعديل نسبة الأبعاد لمنع الـ Overflow في الشاشات المختلفة
    double childAspectRatio = 0.68;
    if (screenWidth < 360) {
      childAspectRatio = 1.1; // كارت عريض عند وجود عمود واحد
    } else if (screenWidth > 600) {
      childAspectRatio = 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state.status == FavoriteStatus.error && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == FavoriteStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 80, color: AppColors.primary),
                  const SizedBox(height:AppSpacing.sm),
                  const Text("Your taste isn't here yet",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color: AppColors.icon),
                  ),
                  const Text("Save what you like and this space will",
                    style: TextStyle(fontSize: 18, color: AppColors.icon),
                  ),
                  const Text("start to look like you.",
                    style: TextStyle(fontSize: 18, color: AppColors.icon),
                  ),
                  const SizedBox(height:AppSpacing.xl),
                  ElevatedButton(onPressed: (){context.read<PersistentTabController>().jumpToTab(0);},style: ElevatedButton.styleFrom(padding: EdgeInsets.all(AppSpacing.lg)), child: const Text("Start shopping")),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = state.favoriteProducts[index];
              return CardFavorite(product: product);
            },
          );
        },
      ),
    );
  }
}