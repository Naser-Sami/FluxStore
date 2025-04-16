import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import 'title_with_show_all.dart';

class ProductsSlider extends StatelessWidget {
  const ProductsSlider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final textTheme = context.theme.textTheme;

    return Column(
      children: [
        TitleWithShowAll(title: title, onShowAll: () {}),
        const SizedBox(height: TSize.s20),
        SizedBox(
          height: 287,
          child: ListView.separated(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: 14,
            separatorBuilder:
                (context, index) => const SizedBox(width: TSize.s10),
            itemBuilder: (context, index) {
              final bool paddingOnFirst = index == 0;
              final bool paddingOnLast = index == 13;
              return Padding(
                padding: EdgeInsets.only(
                  left: paddingOnFirst ? TPadding.p24 : 0,
                  right: paddingOnLast ? TSize.s24 : 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductItem(index: index, controller: controller),
                    const SizedBox(height: TSize.s14),
                    TextWidget(
                      "Long Sleeve Shirt",
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextWidget(
                      "\$100.00",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ).scaleAnimation(scaleBegin: const Offset(1.3, 1.3)),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.index, required this.controller});

  final int index;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: () {},
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double offset = 0;

          if (controller.hasClients) {
            offset = controller.offset - index * 134;
          }

          final double scale = (1 - (offset.abs() / 1000)).clamp(0.95, 1.0);
          final double opacity = (1 - (offset.abs() / 500)).clamp(0.5, 1.0);

          return Opacity(
            opacity: opacity,
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: Container(
          height: 227,
          width: 134,
          decoration: BoxDecoration(
            color:
                TFunctions.isDarkMode(context)
                    ? TFunctions.generateRandomLightColor().withValues(
                      alpha: 0.4,
                    )
                    : TFunctions.generateRandomDarkColor().withValues(
                      alpha: 0.1,
                    ),
            borderRadius: BorderRadius.circular(TPadding.p16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(TPadding.p16),
            child: Image.asset(
              "assets/images/women-feature-products-${index + 1}.png",
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
