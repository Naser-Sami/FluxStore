import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class FashionCollectionDesignBanner extends StatelessWidget {
  const FashionCollectionDesignBanner({
    super.key,
    required this.hint,
    required this.title,
    required this.image,
    required this.height,
  });

  final String hint;
  final String title;
  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return SizedBox(
      height: height,
      width: context.screenWidth,
      child:
          ColoredBox(
            color: color.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget(hint),
                          const SizedBox(height: TSize.s12),
                          TextWidget(
                            title,
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: height,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Center(
                          child: Container(
                            height: 140,
                            width: 140,
                            padding: const EdgeInsets.all(TPadding.p12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.surfaceContainer,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color.surfaceContainerHighest,
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/$image.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).scaleAnimation(),
    );
  }
}
