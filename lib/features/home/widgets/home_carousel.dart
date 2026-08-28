import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:velora/models/carousel_slider.dart' ;

class HomeCarousel extends StatelessWidget {
  final List<CarouselSliders> sliders;
  const HomeCarousel({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: dummySliders.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Image.asset(dummySliders[itemIndex].imageUrl));
      },
      
      options: CarouselOptions(
        // height: 400,
        autoPlay: true,
      ),
    );
  }
}
