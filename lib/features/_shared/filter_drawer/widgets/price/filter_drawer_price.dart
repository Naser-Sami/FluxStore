import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TSize, TextWidget;
import 'filter_drawer_price_slider.dart';

class FilterDrawerPrice extends StatelessWidget {
  const FilterDrawerPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: TSize.s04,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
          child: TextWidget('Price', style: textTheme.titleMedium),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: TPadding.p12),
          child: FilterDrawerPriceSlider(),
        ),
      ],
    );
  }
}
