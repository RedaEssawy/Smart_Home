import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:smart_home/core/models/home_carousel_model.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
final size =MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) => 
    FlutterCarousel.builder(itemCount: homeCarouselImages.length, itemBuilder: (context, index, realIndex) =>
     Image.asset(homeCarouselImages[index].imageUrl,fit: BoxFit.fitWidth,), 
    options:FlutterCarouselOptions(
      height: size.height*0.25,
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2
    
    ) ));
  }
}