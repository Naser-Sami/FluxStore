import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '/config/_config.dart' show TRadius;
import '/core/_core.dart' show CurrencyStringExtension;

class FilterDrawerPriceSlider extends StatelessWidget {
  const FilterDrawerPriceSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final handlerDecoration = FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.outline, width: 1.4),
        ),
      ),
    );

    final trackBar = FlutterSliderTrackBar(
      activeTrackBar: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(TRadius.r10),
      ),
      inactiveTrackBar: BoxDecoration(color: colorScheme.outline),
      inactiveTrackBarHeight: 1,
      activeTrackBarHeight: 2,
    );

    final tooltip = FlutterSliderTooltip(
      disabled: false,
      alwaysShowTooltip: true,
      format: (value) => value.toCurrencyString(symbol: '\$', decimalDigits: 0),
      textStyle: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      boxStyle: FlutterSliderTooltipBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(TRadius.r10),
        ),
      ),
      positionOffset: FlutterSliderTooltipPositionOffset(top: 45),
    );

    return FlutterSlider(
      min: 0,
      max: 100,
      values: [0, 100],
      rangeSlider: true,
      tooltip: tooltip,
      handler: handlerDecoration,
      rightHandler: handlerDecoration,
      trackBar: trackBar,
      onDragging: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
        print('handlerIndex: $handlerIndex');
        print('lowerValue: $lowerValue');
        print('upperValue: $upperValue');
      },
    );
  }
}
