import 'package:flutter/material.dart';

import '/config/_config.dart' show TRadius;
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        widget.details.additionalImages
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
                  padding: const EdgeInsets.all(16),
                  children: const [
                    Text('Product Details will go here...'),
                    SizedBox(height: 400), // Dummy content for scroll
                    Text('Product Details will go here...'),
                    SizedBox(height: 400), // Dummy content for scroll
                    Text('Product Details will go here...'),
                    SizedBox(height: 400), // Dummy content for scroll
                    Text('Product Details will go here...'),
                    SizedBox(height: 400), // Dummy content for scroll
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
