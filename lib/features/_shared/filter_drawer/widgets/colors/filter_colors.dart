import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show OnTapScaler, TPadding, TSize, TextWidget;
import '/core/_core.dart' show BuildContextExtensions, TFunctions;
import 'filter_colors_controller.dart';

class FilterDrawerColors extends StatelessWidget {
  const FilterDrawerColors({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: TSize.s04,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
          child: TextWidget('Colors', style: textTheme.titleMedium),
        ),
        SizedBox(
          height: 50,
          width: context.screenWidth,
          child: BlocBuilder<FilterColorsController, List<FilterColorsModel>>(
            builder: (context, state) {
              final controller = context.read<FilterColorsController>();

              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => OnTapScaler(
                      onTap: () => controller.selectColor(state[index].color),
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: EdgeInsetsDirectional.only(
                          end: index == state.length - 1 ? TPadding.p24 : 0,
                          start: index == 0 ? TPadding.p24 : 0,
                        ),
                        decoration: BoxDecoration(
                          color: state[index].color,
                          border:
                              state[index].isSelected
                                  ? Border.all(
                                    width: 2.4,
                                    color: colorScheme.onSurface,
                                  )
                                  : null,
                          shape: BoxShape.circle,
                          boxShadow:
                              state[index].isSelected
                                  ? [
                                    BoxShadow(
                                      color: colorScheme.scrim.withValues(
                                        alpha:
                                            TFunctions.isDarkMode(context)
                                                ? 0.9
                                                : 0.1,
                                      ),
                                      blurRadius: 2.4,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                  : [],
                        ),
                      ),
                    ),
                separatorBuilder:
                    (context, index) => const SizedBox(width: TSize.s12),
                itemCount: state.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
