import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart'
    show BottomNavigationBarCubit, IconWidget, OnTapScaler;
import '/core/_core.dart' show BuildContextExtensions;
import '/features/_features.dart' show DrawerCubit;

class BottomNavigationBarIconWidget extends StatelessWidget {
  const BottomNavigationBarIconWidget({
    required this.index,
    required this.iconName,
    this.label = '',
  });

  final int index;
  final String iconName;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.onSurface;
    return Expanded(
      child: SizedBox(
        width: context.screenWidth,
        // height: 24,
        child: OnTapScaler(
          onTap: () {
            context.read<BottomNavigationBarCubit>().changeIndex(index);
            context.read<DrawerCubit>().selectItem(index);
          },
          child: BlocBuilder<BottomNavigationBarCubit, int>(
            builder: (context, state) {
              return IconWidget(
                name: iconName,
                width: 24,
                color: state == index ? color : color.withValues(alpha: 0.50),
              );
            },
          ),
        ),
      ),
    );
  }
}
