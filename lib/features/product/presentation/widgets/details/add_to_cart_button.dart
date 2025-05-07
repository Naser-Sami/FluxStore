import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TRadius, TSize, OnTapScaler;
import '/core/_core.dart' show BuildContextExtensions, StringTransform;

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Positioned(
      bottom: 0,
      child: Container(
        height: 90,
        width: context.screenWidth,
        padding: const EdgeInsets.only(bottom: TPadding.p10),
        decoration: BoxDecoration(
          color: color.onSurface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TRadius.r20),
            topRight: Radius.circular(TRadius.r20),
          ),
        ),
        child: OnTapScaler(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag_outlined, color: color.surface),
              const SizedBox(width: TSize.s08),
              Text(
                'Add to cart'.asTitleCase,
                style: context.textTheme.titleLarge?.copyWith(
                  color: color.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
