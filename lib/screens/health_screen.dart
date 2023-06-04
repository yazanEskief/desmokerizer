import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

import 'package:desmokrizer/models/user.dart';
import 'package:desmokrizer/widgets/HealthScreenWidgets/healthSlides/first_slide.dart';
import 'package:desmokrizer/widgets/HealthScreenWidgets/healthSlides/second_slide.dart';
import 'package:desmokrizer/widgets/HealthScreenWidgets/healthSlides/third_slide.dart';
import 'package:desmokrizer/widgets/HealthScreenWidgets/healthSlides/fourth_slide.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> slides = [
      const FirstSlide(),
      const SecondSlide(),
      const ThirdSlide(),
      const FourthSlide(),
    ];
    return CarouselSlider.builder(
      itemCount: slides.length,
      initialPage: 0,
      slideIndicator: CircularSlideIndicator(
        alignment: const Alignment(0, 0.95),
        indicatorBackgroundColor: Colors.grey,
        currentIndicatorColor: const Color.fromARGB(255, 123, 97, 255),
      ),
      slideTransform: const FlipHorizontalTransform(),
      slideBuilder: (index) {
        return slides[index];
      },
    );
    // return FirstSlide(user: widget.user);
  }
}
