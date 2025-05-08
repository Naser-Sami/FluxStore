import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show ExpansionTileWidget, OnTapScaler, TSize, TextWidget;
import '/core/_core.dart' show BuildContextExtensions, LocaleKeys;
import '/features/product/_product.dart'
    show ProductDetails, RateProductScreen, Review;
import 'product_details_reviews_body.dart';

class ProductDetailsReviews extends StatefulWidget {
  const ProductDetailsReviews({super.key, required this.product});
  final ProductDetails product;

  @override
  State<ProductDetailsReviews> createState() => _ProductDetailsReviewsState();
}

class _ProductDetailsReviewsState extends State<ProductDetailsReviews> {
  List<int> starCounts = [];
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    _getReviews();
    _getStars();
  }

  void _getReviews() {
    reviews = widget.product.reviews;
  }

  void _getStars() {
    starCounts = List.filled(5, 0);
    for (final review in reviews) {
      starCounts[review.rating.toInt() - 1]++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final product = widget.product;

    final int total = starCounts.fold(0, (sum, count) => sum + count);

    List<double> percentages =
        starCounts.map((count) {
          if (total == 0) return 0.0;
          return (count / total) * 100;
        }).toList();

    return ExpansionTileWidget(
      initiallyExpanded: true,
      title: const TextWidget(LocaleKeys.Product_reviews),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: product.averageRating.toString(),
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '  out of '.toUpperCase()),
                    const TextSpan(text: '5'),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 5; i++) const Icon(Icons.star),
                  ],
                ),
                const SizedBox(height: TSize.s04),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(text: product.reviews.length.toString()),
                      TextSpan(
                        text:
                            product.reviews.length > 1 ? ' Ratings' : ' Rating',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: TSize.s20),

        // Reviews bars
        Column(
          children: List.generate(5, (index) {
            final star = 5 - index; // To start from 5 stars at the top
            final percent = percentages[star - 1];
            final text = "${percent.toStringAsFixed(0)}%";

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(
                    "$star",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.star, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: color.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              height: 6,
                              width: constraints.maxWidth * (percent / 100),
                              decoration: BoxDecoration(
                                color: color.secondary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(text),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: TSize.s30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(text: product.reviews.length.toString()),
                    const TextSpan(text: ' '),
                    TextSpan(text: LocaleKeys.Product_reviews.tr()),
                  ],
                ),
              ),
            ),
            OnTapScaler(
              onTap:
                  () => context.push(
                    RateProductScreen.routeName,
                    extra: {'productId': product.id},
                  ),
              child: Row(
                children: [
                  Text('Write a review'.toUpperCase()),
                  const SizedBox(width: TSize.s04),
                  Icon(Icons.edit, color: color.secondary, size: 20),
                ],
              ),
            ),
          ],
        ),
        ProductDetailsReviewsBody(reviews: product.reviews),
      ],
    );
  }
}
