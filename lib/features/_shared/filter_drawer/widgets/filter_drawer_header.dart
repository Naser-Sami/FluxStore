import 'package:flutter/material.dart';

import '/config/_config.dart'
    show IconWidget, OnTapScaler, TPadding, TSize, TextWidget;
import '/core/_core.dart' show scaffoldKey;

class FilterDrawerHeader extends StatelessWidget {
  const FilterDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
      child: Column(
        spacing: TSize.s24,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget('Filter', style: textTheme.titleLarge),
              OnTapScaler(
                onTap: () => scaffoldKey.currentState?.closeEndDrawer(),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: IconWidget(
                    name: 'filter',
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: colorScheme.outline, height: 1, thickness: 0.9),
        ],
      ),
    );
  }
}
