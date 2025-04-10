import 'package:flutter/material.dart';
import 'package:flux_store/features/_features.dart' show CollectionsSliderBody;

import '/core/_core.dart' show AnimatedWidgetX, BuildContextExtensions;

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
    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?q=80&w=3774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1603189343302-e603f7add05a?q=80&w=3774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?q=80&w=3870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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

    return SizedBox(
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
    ).scaleAnimation(scaleBegin: const Offset(1.3, 1.3));
  }
}
