import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/product/_product.dart';

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
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            product.additionalImages
                                .map(
                                  (image) => SizedBox(
                                    width: context.screenWidth,
                                    child: CachedNetWorkImageComponent(
                                      imageUrl: ApiEndpoints.imageUrl + image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                                .toList(),
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
                              FavoriteIcon(product: product),
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
                        ProductDetailsTitlePrice(product: product),
                        const SizedBox(height: TSize.s20),
                        const Divider(),
                        const SizedBox(height: TSize.s16),
                        Row(
                          children: [
                            ProductDetailsColors(product: product),
                            ProductDetailsSizes(product: product),
                          ],
                        ),
                        const SizedBox(height: TSize.s34),
                        const Divider(),
                        const SizedBox(height: TSize.s08),
                        ProductDetailsDescription(
                          description: product.description,
                        ),
                        ProductDetailsReviews(product: product),
                        const SimilarProducts(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                  const AddToCartButton(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
