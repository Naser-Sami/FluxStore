import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class ProductsSlider extends StatelessWidget {
  const ProductsSlider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: TPadding.p32.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(title, style: context.textTheme.titleLarge),
              OnTapScaler(
                onTap: () {},
                child: TextWidget(
                  LocaleKeys.Common_showAll,
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: TSize.s20),
        SizedBox(
          height: 227,
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
                  left: paddingOnFirst ? TPadding.p32 : 0,
                  right: paddingOnLast ? TSize.s32 : 0,
                ),
                child: ProductItem(index: index, controller: controller),
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
    return AnimatedBuilder(
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
                  ? TFunctions.generateRandomLightColor().withValues(alpha: 0.4)
                  : TFunctions.generateRandomDarkColor().withValues(alpha: 0.1),
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
    );
  }
}
