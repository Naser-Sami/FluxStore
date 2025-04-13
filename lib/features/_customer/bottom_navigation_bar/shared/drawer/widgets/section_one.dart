import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show DrawerCubit, DrawerItem;

class DrawerSectionOne extends StatelessWidget {
  const DrawerSectionOne({
    super.key,
    required this.navigationShell,
    required this.onItemSelected,
  });
  final StatefulNavigationShell navigationShell;
  final VoidCallback onItemSelected;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return BlocBuilder<DrawerCubit, List<DrawerItem>>(
      builder: (context, items) {
        return ListView.builder(
          key: UniqueKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length - 3,
          itemBuilder: (context, index) {
            final item = items[index];

            return Stack(
              key: ValueKey('SectionOneItem-$index'),
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  height: 56,
                  width: item.isSelected ? context.screenWidth * 0.6 : 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TRadius.r10),
                    child: ColoredBox(
                      color:
                          item.isSelected
                              ? color.primaryContainer.withValues(alpha: 0.30)
                              : Colors.transparent,
                    ),
                  ),
                ),
                OnTapScaler(
                  onTap: () async {
                    context.read<DrawerCubit>().selectItem(index);
                    context.read<BottomNavigationBarCubit>().changeIndex(index);
                    navigationShell.goBranch(
                      index,
                      initialLocation: index == navigationShell.currentIndex,
                    );
                    await Future.delayed(
                      const Duration(milliseconds: 300),
                      onItemSelected,
                    );
                  },
                  child: ListTile(
                    leading: IconWidget(
                      width: 18,
                      height: 18,
                      name: item.icon,
                      color: color.onSurface,
                    ),
                    title: TextWidget(
                      item.title,
                      style: textStyle.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
