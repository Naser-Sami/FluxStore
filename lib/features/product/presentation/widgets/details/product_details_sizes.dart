import 'package:flutter/material.dart';

import '/config/_config.dart' show TSize, TextWidget, TPadding;
import '/core/_core.dart' show BuildContextExtensions;
import '/features/product/_product.dart' show ProductDetails;

class ProductDetailsSizes extends StatelessWidget {
  const ProductDetailsSizes({super.key, required this.product});

  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget('Size'),
          const SizedBox(height: TSize.s10),
          Row(
            children:
                product.availableSizes
                    .map(
                      (size) => Container(
                        width: 33,
                        height: 33,
                        margin: const EdgeInsets.all(TPadding.p04),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Text(size),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
