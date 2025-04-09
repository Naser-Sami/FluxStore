import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart' show BuildContextExtensions;
import '/features/_features.dart'
    show CategoryBloc, CategoryItem, CategoryState;

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: context.screenWidth,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          print(state.categories);

          if (state.isLoading) {
            return const SizedBox(
              width: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          }
          if (state.categories.isEmpty) {
            return const SizedBox.shrink();
          }
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            separatorBuilder: (context, index) => SizedBox(width: TSize.s34.r),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return CategoryItem(
                onCategoryTap: () {},
                name: category.name,
                icon: category.iconName,
              );
            },
          );
        },
      ),
    );
  }
}
