
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'screen1.dart';
import 'screen2.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller for the PageView
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of items for the PageView
  final List<Widget> _pages = [
    OnBoardingScreen1(),
    OnBoardingScreen2()

  ];

  @override
  void initState() {
    super.initState();

    // Listen to the PageView controller to update the current page
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          // PageView with custom pages
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
            ),
          ),
          // SmoothPageIndicator for dots
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _pages.length,
              effect: ExpandingDotsEffect(
                dotWidth: 12,
                dotHeight: 12,
                activeDotColor: Colors.blue,
                dotColor: Colors.grey,
                spacing: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
