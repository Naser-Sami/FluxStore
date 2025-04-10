import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flux_store/config/_config.dart';
import 'package:flux_store/features/_features.dart'
    show CollectionsSliderDotIndicators;

class CollectionsSliderBody extends StatelessWidget {
  const CollectionsSliderBody({
    super.key,
    required this.color,
    required int currentPage,
    required this.index,
    required this.images,
  }) : _currentPage = currentPage;

  final ColorScheme color;
  final int _currentPage;
  final int index;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          decoration: BoxDecoration(
            color: color.primary.withValues(alpha: 0.05 * (index + 1)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                // 🌀 Animated scaling image
                AnimatedScale(
                  duration: const Duration(milliseconds: 500),
                  scale: _currentPage == index ? 1.0 : 1.2,
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const SizedBox(
                          height: 20,
                          width: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),

                ColoredBox(color: Colors.black.withValues(alpha: 0.30)),

                // 🔘 Dot indicators
                CollectionsSliderDotIndicators(
                  images: images,
                  currentPage: _currentPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
