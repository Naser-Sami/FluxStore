import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart' show BuildContextExtensions;

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.onCategoryTap,
    required this.name,
    required this.icon,
  });

  final VoidCallback onCategoryTap;
  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    return OnTapScaler(
      onTap: onCategoryTap,
      child: FadeInLeftBig(
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
                padding: const EdgeInsets.all(TPadding.p08),
                decoration: BoxDecoration(
                  color: color.primary,
                  shape: BoxShape.circle,
                ),
                child: IconWidget(name: icon, color: color.onPrimary),
              ),
            ),
            SizedBox(height: TPadding.p04.r),
            TextWidget(name, style: context.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
