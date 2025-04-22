import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flux_store/config/_config.dart';
import 'package:flux_store/features/product/_product.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';

class ProductDetailsBodyWidget extends StatefulWidget {
  const ProductDetailsBodyWidget({super.key, required this.details});

  final ProductDetails details;

  @override
  State<ProductDetailsBodyWidget> createState() =>
      _ProductDetailsBodyWidgetState();
}

class _ProductDetailsBodyWidgetState extends State<ProductDetailsBodyWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    getReviews();
    getStars();

    _scrollController.addListener(() {
      // if user scrolls down, expand the container
      if (_scrollController.offset > 50 && !_isExpanded) {
        setState(() {
          _isExpanded = true;
        });
      }

      // if user scrolls up to top, collapse the container again
      if (_scrollController.offset <= 50 && _isExpanded) {
        setState(() {
          _isExpanded = false;
        });
      }
    });
  }

  Color bgColor() {
    if (TFunctions.isDarkMode(context)) {
      return TFunctions.generateRandomLightColor().withValues(alpha: 0.4);
    }
    return TFunctions.generateRandomDarkColor().withValues(alpha: 0.1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Review> reviews = [];
  List<int> starCounts = [];

  void getReviews() {
    reviews = widget.details.reviews;
  }

  void getStars() {
    starCounts = List.filled(5, 0);
    for (final review in reviews) {
      starCounts[review.rating.toInt() - 1]++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final color = context.theme.colorScheme;
    final product = widget.details;

    final int total = starCounts.fold(0, (sum, count) => sum + count);

    List<double> percentages =
        starCounts.map((count) {
          if (total == 0) return 0.0;
          return (count / total) * 100;
        }).toList();

    print('''
------------------------------------------------------------------------------------
Page Rebuilds Again
------------------------------------------------------------------------------------
''');

    return SizedBox(
      height: height,
      width: context.screenWidth,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            height: _isExpanded ? height * 0.27 : height * 0.50,
            color: bgColor().withValues(alpha: 0.1),
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              height: _isExpanded ? height * 0.15 : height * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor().withValues(alpha: 0.2),
              ),
            ),
          ),
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: _isExpanded ? height * 0.25 : height * 0.43,
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      Hero(
                        tag: "Product-${product.id}",
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                              product.additionalImages
                                  .map(
                                    (image) => SizedBox(
                                      width: context.screenWidth,
                                      child: Image.asset(
                                        'assets/images/$image.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: context.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: TPadding.p24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OnTapScaler(
                                onTap: () => context.pop(),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              OnTapScaler(
                                onTap: () {},
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ Animated height based on scroll
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    height: _isExpanded ? height * 0.75 : height * 0.57,
                    decoration: BoxDecoration(
                      color: color.surface,
                      boxShadow: [
                        BoxShadow(
                          color: color.shadow.withValues(
                            alpha: TFunctions.isDarkMode(context) ? 1.0 : 0.2,
                          ),
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(TRadius.r20),
                        topRight: Radius.circular(TRadius.r20),
                      ),
                    ),
                    child: ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        vertical: TPadding.p53,
                        horizontal: TPadding.p28,
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(fontSize: 18),
                                ),
                                const SizedBox(height: TSize.s08),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        for (int i = 0; i < 5; i++)
                                          const Icon(Icons.star),
                                      ],
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          const TextSpan(text: '('),
                                          TextSpan(
                                            text:
                                                product.reviews.length
                                                    .toString(),
                                          ),
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
                        ),
                        const SizedBox(height: TSize.s20),
                        const Divider(),
                        const SizedBox(height: TSize.s16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget('Color'),
                                  const SizedBox(height: TSize.s10),
                                  Row(
                                    children:
                                        product.availableColors
                                            .map(
                                              (color) => Container(
                                                width: 33,
                                                height: 33, // 25
                                                margin: const EdgeInsets.all(
                                                  TPadding.p04,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: color.toColor(),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
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
                                                margin: const EdgeInsets.all(
                                                  TPadding.p04,
                                                ),
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
                            ),
                          ],
                        ),
                        const SizedBox(height: TSize.s34),
                        const Divider(),
                        const SizedBox(height: TSize.s08),
                        ExpansionTileWidget(
                          initiallyExpanded: true,
                          title: const TextWidget(
                            LocaleKeys.Product_description,
                          ),
                          children: [Text(product.description)],
                        ),
                        ExpansionTileWidget(
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
                                          text:
                                              product.averageRating.toString(),
                                          style: context
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        TextSpan(
                                          text: '  out of '.toUpperCase(),
                                        ),
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
                                        for (int i = 0; i < 5; i++)
                                          const Icon(Icons.star),
                                      ],
                                    ),
                                    const SizedBox(height: TSize.s04),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text:
                                                product.reviews.length
                                                    .toString(),
                                          ),
                                          TextSpan(
                                            text:
                                                product.reviews.length > 1
                                                    ? ' Ratings'
                                                    : ' Rating',
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
                                final star =
                                    5 -
                                    index; // To start from 5 stars at the top
                                final percent = percentages[star - 1];
                                final text = "${percent.toStringAsFixed(0)}%";

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$star",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                                    color: color.primary
                                                        .withValues(alpha: 0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 6,
                                                  width:
                                                      constraints.maxWidth *
                                                      (percent / 100),
                                                  decoration: BoxDecoration(
                                                    color: color.secondary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
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
                                        TextSpan(
                                          text:
                                              product.reviews.length.toString(),
                                        ),
                                        const TextSpan(text: ' '),
                                        TextSpan(
                                          text: LocaleKeys.Product_reviews.tr(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                OnTapScaler(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Text('Write a review'.toUpperCase()),
                                      const SizedBox(width: TSize.s04),
                                      Icon(
                                        Icons.edit,
                                        color: color.secondary,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: product.reviews.length,
                              separatorBuilder:
                                  (context, index) =>
                                      const SizedBox(height: TSize.s40),
                              itemBuilder: (context, index) {
                                final review = product.reviews[index];

                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        radius: 30,
                                        child: CachedNetWorkImageComponent(
                                          imageUrl: review.imageUrl,
                                        ),
                                      ),
                                      title: Text(review.reviewerName),
                                      subtitle: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              for (int i = 0; i < 5; i++)
                                                const Icon(Icons.star),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              for (
                                                int i = 0;
                                                i < review.rating.toInt();
                                                i++
                                              )
                                                Icon(
                                                  Icons.star,
                                                  color: color.primary,
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        DateTime.parse(
                                          review.date,
                                        ).timeAgo().capitalize(),
                                      ),
                                    ),
                                    const SizedBox(height: TSize.s20),
                                    Text(review.text),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        const ExpansionTileWidget(
                          title: Text('Similar Products'),
                          initiallyExpanded: true,
                          children: [ProductsSlider()],
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                  Positioned(
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
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: color.surface,
                            ),
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
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
