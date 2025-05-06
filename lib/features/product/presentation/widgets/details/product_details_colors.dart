import 'package:flutter/material.dart';

import '/config/_config.dart' show TSize, TextWidget, TPadding;
import '/core/_core.dart' show HexColorExtension;
import '/features/product/_product.dart' show ProductDetails;

class ProductDetailsColors extends StatelessWidget {
  const ProductDetailsColors({super.key, required this.product});

  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget('Color'),
          const SizedBox(height: TSize.s10),
          Builder(
            builder: (context) {
              try {
                return Row(
                  children:
                      product.availableColors
                          .map(
                            (color) => Container(
                              width: 33,
                              height: 33, // 25
                              margin: const EdgeInsets.all(TPadding.p04),
                              decoration: BoxDecoration(
                                color: color.toColor(),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                          .toList(),
                );
              } catch (e) {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
