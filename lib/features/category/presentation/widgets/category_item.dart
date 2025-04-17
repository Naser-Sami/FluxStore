import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/config/_config.dart';
import '/core/_core.dart' show AnimatedWidgetX, BuildContextExtensions;

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.onCategoryTap,
    required this.name,
    required this.icon,
    required this.isSelected,
  });

  final VoidCallback onCategoryTap;
  final String name;
  final String icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    return OnTapScaler(
      onTap: onCategoryTap,
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(TPadding.p02),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? color.primary : Colors.transparent,
                width: 1,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(TPadding.p08),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? color.primary
                        : color.secondary.withValues(alpha: 0.80),
                shape: BoxShape.circle,
              ),
              child: IconWidget(name: icon, color: color.onPrimary),
            ),
          ),
          const SizedBox(height: TPadding.p04),
          TextWidget(name, style: context.textTheme.bodyMedium),
        ],
      ),
    ).scaleAnimation();
  }
}

class ShimmerCategoryItem extends StatelessWidget {
  const ShimmerCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    return Expanded(
      child:
          OnTapScaler(
            onTap: () {},
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(TPadding.p02),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color.primary, width: 1),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(TPadding.p01),

                    child: Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          color.primary,
                          color.primary.withValues(alpha: 0.5),
                          color.primary.withValues(alpha: 0.4),
                          color.primary.withValues(alpha: 0.3),
                          color.primary.withValues(alpha: 0.2),
                        ],
                      ),
                      child: const IconSkeleton(dimension: 42, radius: 42),
                    ),
                  ),
                ),
                const SizedBox(height: TPadding.p04),
                TextSkeleton(
                  textStyle: context.textTheme.bodyMedium!,
                  widthFactor: 0.5,
                  radius: 50,
                ),
              ],
            ),
          ).scaleAnimation(),
    );
  }
}
