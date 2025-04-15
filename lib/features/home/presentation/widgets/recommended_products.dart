import 'package:flutter/material.dart';
import 'package:flux_store/config/shared/styles/_styles.dart';

import '/config/_config.dart' show TPadding, TRadius, TSize;
import '/core/_core.dart';
import '/features/_features.dart' show TitleWithShowAll;

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Column(
      children: [
        TitleWithShowAll(title: 'Recommended', onShowAll: () {}),
        const SizedBox(height: TSize.s20),
        SizedBox(
          height: 80,
          width: context.screenWidth,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final bool paddingOnFirst = index == 0;
              final bool paddingOnLast = index == 3;

              return Padding(
                padding: EdgeInsets.only(
                  left: paddingOnFirst ? TPadding.p24 : 0,
                  right: paddingOnLast ? TSize.s24 : 0,
                ),
                child:
                    OnTapScaler(
                      onTap: () {},
                      child: Container(
                        width: context.screenWidth * 0.70,
                        margin: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          color: color.surface,
                          borderRadius: BorderRadius.circular(TRadius.r12),
                          boxShadow: [
                            BoxShadow(
                              color: color.shadow.withValues(
                                alpha:
                                    TFunctions.isDarkMode(context) ? 1.0 : 0.2,
                              ),
                              offset: const Offset(0, 2),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 76,
                              child: Image.asset(
                                'assets/images/women-feature-products-${index + 1}.png',
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Name',
                                  style: context.textTheme.titleSmall,
                                ),
                                Text(
                                  '\$99.99',
                                  style: context.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ).scaleAnimation(),
              );
            },
            separatorBuilder:
                (context, index) => const SizedBox(width: TSize.s15),
            itemCount: 4,
          ),
        ),
      ],
    );
  }
}
