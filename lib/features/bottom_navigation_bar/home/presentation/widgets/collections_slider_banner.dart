import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flux_store/features/_features.dart' show CollectionsSliderBody;

import '/core/_core.dart' show BuildContextExtensions;

class CollectionsSliderBanner extends StatefulWidget {
  const CollectionsSliderBanner({super.key});

  @override
  State<CollectionsSliderBanner> createState() =>
      _CollectionsSliderBannerState();
}

class _CollectionsSliderBannerState extends State<CollectionsSliderBanner> {
  late final PageController _pageController;
  int _currentPage = 0;

  final List<String> images = [
    'https://images.unsplash.com/photo-1736344319749-93bc29f03d5d?q=80&w=3870&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1743083931860-05b751559acb?q=80&w=3870&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1743110337303-2edffbeab0b1?q=80&w=3764&auto=format&fit=crop',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7, initialPage: 1);
    _currentPage = 1;

    // Trigger scaling once layout is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return FadeIn(
      child: SizedBox(
        height: 168,
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          onPageChanged: (value) {
            setState(() {
              _currentPage = value;
            });
          },
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double scale = 1.0;
                if (_pageController.hasClients &&
                    _pageController.position.hasContentDimensions) {
                  final pageOffset =
                      (_pageController.page ?? _pageController.initialPage) -
                      index;
                  scale = (1 - (pageOffset.abs() * 0.3)).clamp(0.82, 1.0);
                }

                return Center(
                  child: SizedBox(
                    height: 168 * scale,
                    width: 340 * scale,
                    child: child,
                  ),
                );
              },
              child: CollectionsSliderBody(
                color: color,
                currentPage: _currentPage,
                index: index,
                images: images,
              ),
            );
          },
        ),
      ),
    );
  }
}
