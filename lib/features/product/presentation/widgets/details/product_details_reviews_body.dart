import 'package:flutter/material.dart';

import '/config/_config.dart' show CachedNetWorkImageComponent, TRadius, TSize;
import '/core/_core.dart'
    show
        ApiEndpoints,
        BuildContextExtensions,
        HumanReadableDateTime,
        StringTransform;
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
                child: CachedNetWorkImageComponent(
                  imageUrl: ApiEndpoints.imageUrl + review.reviewerImage,
                ),
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
            SizedBox(
              width: context.screenWidth,
              child: Text(review.description, textAlign: TextAlign.start),
            ),
            const SizedBox(height: TSize.s16),
            Wrap(
              children: [
                for (var image in review.images)
                  Padding(
                    padding: const EdgeInsets.only(right: TSize.s08),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(TRadius.r16),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetWorkImageComponent(
                          imageUrl: ApiEndpoints.imageUrl + image,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
