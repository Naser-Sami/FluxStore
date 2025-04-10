import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart' show BuildContextExtensions, LocaleKeys;
import '/features/_features.dart'
    show
        CategoryBloc,
        CategoryItem,
        CategoryState,
        SelectedCategoryCubit,
        ShimmerCategoryItem;

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        final category = context.read<CategoryBloc>().state.categories;
        if (category.isNotEmpty) {
          context.read<SelectedCategoryCubit>().select(category.first.id);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TPadding.p32.r,
        ).copyWith(top: TPadding.p28.r),
        child: SizedBox(
          height: 60.h,
          width: context.screenWidth,
          child: Center(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 4; i++) const ShimmerCategoryItem(),
                    ],
                  );
                }

                if (state.isError) {
                  return const Center(
                    child: TextWidget(LocaleKeys.Common_error),
                  );
                }

                if (state.categories.isEmpty) {
                  return const Center(
                    child: TextWidget(LocaleKeys.Common_noResultsFound),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  separatorBuilder:
                      (context, index) => SizedBox(width: TSize.s34.r),
                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    return BlocBuilder<SelectedCategoryCubit, String?>(
                      builder: (context, selectedId) {
                        final isSelected = selectedId == category.id;
                        return CategoryItem(
                          onCategoryTap:
                              () => context
                                  .read<SelectedCategoryCubit>()
                                  .select(category.id),
                          isSelected: isSelected,
                          name: category.name,
                          icon: category.iconName,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
