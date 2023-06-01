import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

import 'package:desmokrizer/models/user.dart';
import 'package:desmokrizer/widgets/healthSlides/first_slide.dart';
import 'package:desmokrizer/widgets/healthSlides/second_slide.dart';
import 'package:desmokrizer/widgets/healthSlides/third_slide.dart';
import 'package:desmokrizer/widgets/healthSlides/fourth_slide.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key, required this.user});

  final User user;

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  var _sliderController = CarouselSliderController();
  var _startPosition;

  @override
  Widget build(BuildContext context) {
    final List<Widget> slides = [
      FirstSlide(user: widget.user),
      SecondSlide(
        user: widget.user,
      ),
      ThirdSlide(user: widget.user),
      FourthSlide(user: widget.user),
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
