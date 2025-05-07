import 'package:flutter/material.dart';

import '/config/_config.dart' show CachedNetWorkImageComponent, TSize;
import '/core/_core.dart'
    show BuildContextExtensions, HumanReadableDateTime, StringTransform;
import '/features/product/_product.dart' show Review;

class ProductDetailsReviewsBody extends StatelessWidget {
  const ProductDetailsReviewsBody({super.key, required this.reviews});
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: TSize.s40),
      itemBuilder: (context, index) {
        final review = reviews[index];

        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 30,
                child: CachedNetWorkImageComponent(imageUrl: review.imageUrl),
              ),
              title: Text(review.reviewerName),
              subtitle: Stack(
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++) const Icon(Icons.star),
                    ],
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < review.rating.toInt(); i++)
                        Icon(Icons.star, color: color.primary),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                DateTime.parse(review.date).timeAgo().capitalize(),
              ),
            ),
            const SizedBox(height: TSize.s20),
            Text(review.text),
          ],
        );
      },
    );
  }
}
