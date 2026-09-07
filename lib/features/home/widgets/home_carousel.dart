import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velora/models/carousel_slider.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    super.key,
    required this.sliders,
  });

  final List<CarouselSliders> sliders;

  @override
  Widget build(BuildContext context) {
    if (sliders.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isMobile = width < 600;
        final bool isTablet = width >= 600 && width < 1024;

        final double height = isMobile
            ? width * 0.52
            : isTablet
                ? 280
                : 340;

        final double viewportFraction = isMobile
            ? 0.94
            : isTablet
                ? 0.90
                : 0.88;

        return CarouselSlider.builder(
          itemCount: sliders.length,
          itemBuilder: (
            context,
            itemIndex,
            pageViewIndex,
          ) {
            final slider = sliders[itemIndex];

            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 3 : 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  isMobile ? 20 : 28,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: isMobile ? 14 : 20,
                    offset: const Offset(0, 8),
                    color: Colors.black.withValues(alpha: 0.10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  isMobile ? 20 : 28,
                ),
                child: Image.asset(
                  slider.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: height,
            viewportFraction: viewportFraction,
            enlargeCenterPage: true,
            enlargeFactor: 0.04,
            autoPlay: sliders.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(
              milliseconds: 800,
            ),
            autoPlayCurve: Curves.easeInOutCubic,
            enableInfiniteScroll: sliders.length > 1,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        );
      },
    );
  }
}
