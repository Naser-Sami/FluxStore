import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show Product, ProductDetailsScreen;

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.index,
    required this.controller,
    required this.product,
  });

  final int index;
  final ScrollController controller;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: () {
        controller.animateTo(
          index * 134,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );

        context.push(
          ProductDetailsScreen.routeName,
          extra: {'productId': product.id},
        );
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double offset = 0;

          if (controller.hasClients) {
            offset = controller.offset - index * 134;
          }

          final double scale = (1 - (offset.abs() / 1000)).clamp(0.95, 1.0);
          final double opacity = (1 - (offset.abs() / 500)).clamp(0.5, 1.0);

          return Opacity(
            opacity: opacity,
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: Container(
          height: 227,
          width: 134,
          decoration: BoxDecoration(
            color:
                TFunctions.isDarkMode(context)
                    ? TFunctions.generateRandomLightColor().withValues(
                      alpha: 0.4,
                    )
                    : TFunctions.generateRandomDarkColor().withValues(
                      alpha: 0.1,
                    ),
            borderRadius: BorderRadius.circular(TPadding.p16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(TPadding.p16),
            child: Hero(
              tag: "Product-${product.id}",
              child: Image.asset(
                "assets/images/${product.imageUrl}.png",
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
