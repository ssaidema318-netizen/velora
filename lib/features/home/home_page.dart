
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/home/cubit/cubit/home_cubit.dart';
import 'package:velora/features/home/widgets/categories_home.dart';
import 'package:velora/features/home/widgets/featured_section.dart';
import 'package:velora/features/home/widgets/flash_deals_section.dart';
import 'package:velora/features/home/widgets/home_carousel.dart';
import 'package:velora/features/home/widgets/header.dart';
import 'package:velora/features/home/widgets/recommend_section.dart';
import 'package:velora/features/home/widgets/section_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🏠 HOME PAGE BUILD');

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            debugPrint('🎨 HOME STATE: ${state.runtimeType}');

            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              );
            }

            if (state is! HomeLoaded) {
              return const SizedBox.shrink();
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = switch (constraints.maxWidth) {
                  < 600 => AppSpacing.md,
                  < 1024 => AppSpacing.l,
                  _ => AppSpacing.xl,
                };

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 1280,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: AppSpacing.md,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Header(),

                            const SizedBox(height: AppSpacing.xl),

                            HomeCarousel(
                              sliders: state.carousel,
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            const SectionHome(
                              title: 'Categories',
                            ),

                            const SizedBox(height: AppSpacing.sm),

                            SizedBox(
                              height: constraints.maxWidth < 600 ? 135 : 155,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.category.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(width: AppSpacing.sm),
                                itemBuilder: (context, index) {
                                  return CategoriesHome(
                                    categoryItem: state.category[index],
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            FeaturedSection(
                              productItem: state.productItem,
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            FlashDealsSection(
                              productItem: state.productItem,
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            RecommendSection(
                              productItem: state.productItem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

