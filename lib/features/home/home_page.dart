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
    // final size =MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeDat();
        return cubit;},
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading){
                return const Center(
                  child: CircularProgressIndicator.adaptive(),

                );
              }
              else if(state is HomeLoaded){
                return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      Header(),
                      SizedBox(height: AppSpacing.xl),
                      HomeCarousel(),
                      SizedBox(height: AppSpacing.xl),
                      SectionHome(title: "Categories"),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: state.category.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => CategoriesHome(
                            categoryItem: state.category[index],
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.xl),
                      FeaturedSection(),
                      SizedBox(height: AppSpacing.xl),
                      FlashDealsSection(),
                      SizedBox(height: AppSpacing.xl),
                      RecommendSection(),
                    ],
                  ),
                ),
              );
              }
              else if(state is HomeError){
                return Center(
                  child: Text(state.message,
                  style: Theme.of(context).textTheme.labelLarge,),
                );
              }

              // Fallback for any other state
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
