import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show TRadius, TSize;
import '/core/_core.dart' show TFunctions, sl;
import 'controllers/_controllers.dart';
import 'widgets/_widgets.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final shadowColor =
        TFunctions.isDarkMode(context)
            ? colorScheme.scrim.withValues(alpha: 0.8)
            : colorScheme.scrim.withValues(alpha: 0.2);

    return MultiBlocProvider(
      providers: [
        BlocProvider<FilterPriceCubit>(
          create: (context) => sl<FilterPriceCubit>()..init(0, 200),
        ),
      ],
      child: Container(
        width: 312,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(TRadius.r60),
          boxShadow: [
            BoxShadow(color: shadowColor, blurRadius: 10, spreadRadius: 10),
          ],
        ),
        child: const SafeArea(
          child: Column(
            spacing: TSize.s24,
            children: [
              FilterDrawerHeader(),
              FilterDrawerBody(),
              FilterDrawerFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
