import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/config/_config.dart'
    show IconWidget, OnTapScaler, TPadding, TRadius, TSize;
import '/core/_core.dart' show BuildContextExtensions, TFunctions;

class RateProductScreen extends StatefulWidget {
  static const routeName = '/rate-product';
  static const String name = 'Rate Product';

  const RateProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  double rating = 0;
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text(RateProductScreen.name)),
      body: SafeArea(
        child: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(TPadding.p32),
            child: Column(
              spacing: TSize.s30,
              children: [
                const SizedBox(height: TSize.s12),
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 0,
                  glow: false,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(Icons.star),
                  onRatingUpdate: (double val) {
                    rating = val;
                  },
                ),

                // Show text field to enter review
                Container(
                  padding: const EdgeInsets.all(TPadding.p16),
                  decoration: BoxDecoration(
                    color: color.surface,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(TRadius.r16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.shadow.withValues(
                          alpha: TFunctions.isDarkMode(context) ? 1 : 0.2,
                        ),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    minLines: 7,
                    maxLines: null,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      hintText:
                          'Would you like to write anything about this product? ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  spacing: TSize.s24,
                  children: [
                    SelectImage(
                      onTap: () async {
                        final val = await TFunctions.pickImages(context);

                        print('images $val');
                      },
                      icon: 'Img_box',
                    ),
                    SelectImage(
                      onTap: () async {
                        final val = await TFunctions.captureImage(context);

                        print('images $val');
                      },
                      icon: 'camera',
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    print('rating: $rating');
                    print('description: ${_descriptionController.text}');
                  },
                  child: const Text('Submit Review'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectImage extends StatelessWidget {
  const SelectImage({super.key, required this.onTap, required this.icon});

  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return OnTapScaler(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        color: color.secondaryContainer,
        dashPattern: [10, 10],
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            height: 64,
            width: 64,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: IconWidget(name: icon, color: color.secondaryContainer),
            ),
          ),
        ),
      ),
    );
  }
}
