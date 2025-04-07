import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show CreateAccountScreen;

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  static const String name = 'Onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;
  int _currentPageIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': LocaleKeys.Onboarding_title1,
      'subtitle': LocaleKeys.Onboarding_subtitle1,
      'image': ImagesPath.onboarding1,
    },
    {
      'title': LocaleKeys.Onboarding_title2,
      'subtitle': LocaleKeys.Onboarding_subtitle2,
      'image': ImagesPath.onboarding2,
    },
    {
      'title': LocaleKeys.Onboarding_title3,
      'subtitle': LocaleKeys.Onboarding_subtitle3,
      'image': ImagesPath.onboarding3,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: context.screenHeight * 0.50,
                  width: context.screenWidth,
                  child: ColoredBox(color: Colors.white),
                ),
                SizedBox(
                  height: context.screenHeight * 0.50,
                  width: context.screenWidth,
                  child: ColoredBox(color: Colors.grey.shade800),
                ),
              ],
            ),
            SizedBox(
              width: context.screenWidth,
              height: context.screenHeight,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      _onboardingData[_currentPage]['title']!,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: Colors.black87,
                      ),
                    ).scaleAnimation(
                      duration: const Duration(milliseconds: 400),
                    ),
                    const SizedBox(height: TSize.s14),
                    TextWidget(
                      _onboardingData[_currentPage]['subtitle']!,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.black87,
                      ),
                    ).scaleAnimation(
                      duration: const Duration(milliseconds: 500),
                    ),
                    const SizedBox(height: TSize.s36),

                    // ✅ PageView with scaling effect
                    SizedBox(
                      height: TSize.s368,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          _currentPage = value;
                          setState(() {});
                        },
                        controller: _pageController,
                        itemCount: _onboardingData.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController
                                  .position
                                  .hasContentDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.3)).clamp(
                                  0.82,
                                  1.0,
                                );
                              }

                              _currentPageIndex = index;

                              return Center(
                                child: SizedBox(
                                  height: TSize.s368 * value,
                                  width: TSize.s262 * value,
                                  child: child,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(TSize.s16),
                              ),
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 500),
                                scale: _currentPage == index ? 1 : 0.8,
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(
                                  _onboardingData
                                      .map((e) => e['image']!)
                                      .toList()[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: TSize.s57),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 500),
                      turns: _currentPageIndex == _currentPage ? 0 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < _onboardingData.length; i++)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: TSize.s08),
                              height: TSize.s08,
                              width: TSize.s08,
                              decoration: BoxDecoration(
                                color:
                                    _currentPage == i
                                        ? Colors.white
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(TSize.s16),
                                border: Border.all(
                                  color:
                                      _currentPage == i
                                          ? Colors.white
                                          : Colors.grey.shade400,
                                  width: 1.4,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSize.s24),
                    CustomButton(
                      onTap: () => context.go(CreateAccountScreen.routeName),
                      textColor: Colors.white,
                      borderColor: Colors.white,
                      text: LocaleKeys.Onboarding_ShoppingNow,
                    ).scaleAnimation(
                      duration: const Duration(milliseconds: 600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
