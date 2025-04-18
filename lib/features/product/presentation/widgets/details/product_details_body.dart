import 'package:flutter/material.dart';
import 'package:flux_store/config/_config.dart';

import '/core/_core.dart';
import '/features/_features.dart' show ProductDetails;

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

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final color = context.theme.colorScheme;
    final product = widget.details;

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
          Container(
            height: height * 0.50,
            color: bgColor().withValues(alpha: 0.1),
            alignment: Alignment.center,
            child: Container(
              height: height * 0.25,
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
                height: _isExpanded ? 0 : height * 0.43,
                child: SafeArea(
                  bottom: false,
                  child: Hero(
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
                ),
              ),

              // ✅ Animated height based on scroll
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: _isExpanded ? height : height * 0.57,
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
                              style: context.textTheme.titleMedium?.copyWith(
                                fontSize: 18,
                              ),
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
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      const TextSpan(text: '('),
                                      TextSpan(
                                        text: product.reviews.length.toString(),
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
                      title: const TextWidget(LocaleKeys.Product_description),
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
                                      text: product.averageRating.toString(),
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
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
                                    for (int i = 0; i < 5; i++)
                                      const Icon(Icons.star),
                                  ],
                                ),
                                const SizedBox(height: TSize.s04),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: product.reviews.length.toString(),
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
