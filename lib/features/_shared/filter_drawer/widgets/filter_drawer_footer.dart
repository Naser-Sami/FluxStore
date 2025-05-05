import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart' show scaffoldKey;
import '/features/_features.dart'
    show ProductQueryParameters, SearchResultScreen;
import '_widgets.dart';

class FilterDrawerFooter extends StatelessWidget {
  const FilterDrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    void onApply() {
      final price = context.read<FilterPriceCubit>().state;
      final colors = context.read<FilterColorsController>().state;

      ProductQueryParameters? queryParameters = ProductQueryParameters(
        search: null,
        minPrice: price.min,
        maxPrice: price.max,
        colors:
            colors.where((e) => e.isSelected).map((e) {
              final hex = e.color.toHexString();
              return hex;
            }).toList(),
      );

      context.push(SearchResultScreen.routeName, extra: queryParameters);
      scaffoldKey.currentState?.closeEndDrawer();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TPadding.p32,
        vertical: TPadding.p24,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onTap: () {
                context.read<FilterPriceCubit>().reset(20, 80);
                context.read<FilterColorsController>().reset();
              },
              text: 'Reset',
              textColor: colorScheme.onSurface,
              backgroundColor: colorScheme.surface,
              borderColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: TPadding.p15),
            ),
          ),

          Expanded(
            child: CustomButton(
              onTap: onApply,
              text: 'Apply',
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: TPadding.p15),
            ),
          ),
        ],
      ),
    );
  }
}
