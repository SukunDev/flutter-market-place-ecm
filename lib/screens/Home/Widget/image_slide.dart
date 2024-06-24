import 'package:flutter/material.dart';
import 'dart:async';

class ImageSlider extends StatefulWidget {
  final Function(int) onChange;
  final int currentSlide;
  final bool autoplay;
  final bool animate;

  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
    this.autoplay = true, // autoplay diatur secara default bergerak
    this.animate = true, // animasi
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentSlide);
    if (widget.autoplay) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage == 5) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: widget.animate
              ? const Duration(milliseconds: 400)
              : Duration.zero,
          curve: widget.animate ? Curves.easeInOut : Curves.linear,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: widget.onChange,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "assets/slide1.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/slide2.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/slide3.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/slide4.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/slider3.png",
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
