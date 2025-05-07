import 'package:flutter/material.dart';

import '/config/_config.dart' show TSize;
import '/core/_core.dart' show BuildContextExtensions;
import '/features/_features.dart' show ProductDetails;

class ProductDetailsTitlePrice extends StatelessWidget {
  const ProductDetailsTitlePrice({super.key, required this.product});
  final ProductDetails product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.name,
              style: context.textTheme.titleMedium?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: TSize.s08),
            Row(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 5; i++) const Icon(Icons.star),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(text: '('),
                      TextSpan(text: product.reviews.length.toString()),
                      const TextSpan(text: ')'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          "\$ ${product.price.toStringAsFixed(2)}",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
