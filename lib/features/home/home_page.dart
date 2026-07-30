import 'package:flutter/material.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/home/widgets/categories_home.dart';
import 'package:velora/features/home/widgets/featured_section.dart';
import 'package:velora/features/home/widgets/home_carousel.dart';
import 'package:velora/features/home/widgets/header.dart';
import 'package:velora/features/home/widgets/section_home.dart';
import 'package:velora/models/categories_home_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    itemCount: dummyCategories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        CategoriesHome(categoryItem: dummyCategories[index]),
                  ),
                ),
                SizedBox(height: AppSpacing.xl),
                FeaturedSection()
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
