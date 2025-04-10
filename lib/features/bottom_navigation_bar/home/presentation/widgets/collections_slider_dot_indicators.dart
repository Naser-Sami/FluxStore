import 'package:flutter/material.dart';

import '/config/_config.dart' show TSize;

class CollectionsSliderDotIndicators extends StatelessWidget {
  const CollectionsSliderDotIndicators({
    super.key,
    required this.images,
    required int currentPage,
  }) : _currentPage = currentPage;

  final List<String> images;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: Row(
        children: List.generate(images.length, (i) {
          final isActive = i == _currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: TSize.s08),
            height: isActive ? TSize.s14 : TSize.s10,
            width: isActive ? TSize.s14 : TSize.s10,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border:
                  isActive ? Border.all(color: Colors.white, width: 1) : null,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
