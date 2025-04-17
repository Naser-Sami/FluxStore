import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class DiscoverCollectionBaseItem extends StatelessWidget {
  const DiscoverCollectionBaseItem({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        TFunctions.isDarkMode(context)
            ? TFunctions.generateRandomLightColor().withValues(alpha: 0.4)
            : TFunctions.generateRandomDarkColor().withValues(alpha: 0.1);

    return Container(
      width: context.screenWidth,
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(TRadius.r16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            'Clothes'.toUpperCase(),
            style: context.textTheme.titleLarge?.copyWith(
              color:
                  TFunctions.isDarkColor(bgColor) ? Colors.black : Colors.white,
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Container(
                  height: 110,
                  width: 110,
                  padding: const EdgeInsets.all(TPadding.p12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor.withValues(alpha: 0.2),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
              Image.asset(
                'assets/images/women-feature-products-5.png',
                fit: BoxFit.fill,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
