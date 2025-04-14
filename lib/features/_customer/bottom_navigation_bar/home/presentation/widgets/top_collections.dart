import 'package:flutter/material.dart';

import '/config/_config.dart' show OnTapScaler, TPadding, TSize, TextWidget;
import '/core/_core.dart' show BuildContextExtensions;
import '/features/_features.dart'
    show TitleWithShowAll, FashionCollectionDesignBanner;

class TopCollections extends StatelessWidget {
  const TopCollections({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Column(
      children: [
        TitleWithShowAll(title: 'Top Collections', onShowAll: () {}),
        const SizedBox(height: TSize.s20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
          child: OnTapScaler(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TSize.s12),
              child: const FashionCollectionDesignBanner(
                height: 158,
                hint: '| Sale Up to 40%',
                title: 'FOR SLIM\n& BEAUTY',
                image: 'women-feature-products-7',
              ),
            ),
          ),
        ),
        const SizedBox(height: TSize.s20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
          child: OnTapScaler(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TSize.s12),
              child: const FashionCollectionDesignBanner(
                height: 229,
                hint: '| Summer Collection\n2025',
                title: 'Most sexy\n& fabulous\ndesign',
                image: 'women-feature-products-8',
              ),
            ),
          ),
        ),
        const SizedBox(height: TSize.s20),
        SizedBox(
          height: 200,
          width: context.screenWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: OnTapScaler(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(TSize.s12),
                        child: ColoredBox(
                          color: color.surfaceContainerLow,
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/women-feature-products-10.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const TextWidget('T-Shirt'),
                                    const SizedBox(height: TSize.s12),
                                    TextWidget(
                                      'The\nOffice\nLife',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSize.s20),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: OnTapScaler(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(TSize.s12),
                        child: ColoredBox(
                          color: color.surfaceContainerLow,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const TextWidget('Dresses'),
                                    const SizedBox(height: TSize.s12),
                                    TextWidget(
                                      'Elegant\nDesign',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/images/women-feature-products-9.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
