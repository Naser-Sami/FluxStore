import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart' show BuildContextExtensions, LocaleKeys;
import '/features/_features.dart'
    show
        CategoryBloc,
        CategoryState,
        GetProductsEvent,
        ProductQueryParameters,
        ProductsBloc,
        SelectedCategoryCubit;
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        final category = context.read<CategoryBloc>().state.categories;
        if (category.isNotEmpty) {
          context.read<SelectedCategoryCubit>().select(category.first.id);

          context.read<ProductsBloc>().add(
            GetProductsEvent(
              queryParameters: ProductQueryParameters(
                categoryId: category.first.id,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: TPadding.p28),
        child: SizedBox(
          height: 70,
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
                      (context, index) => const SizedBox(width: TSize.s34),
                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    return BlocBuilder<SelectedCategoryCubit, String?>(
                      builder: (context, selectedId) {
                        final isSelected = selectedId == category.id;
                        return CategoryItem(
                          onCategoryTap:
                              () => _onCategoryTap(context, category.id),
                          isSelected: isSelected,
                          name: category.name,
                          icon: category.imageUrl,
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

  void _onCategoryTap(BuildContext context, String categoryId) {
    context.read<SelectedCategoryCubit>().select(categoryId);

    context.read<ProductsBloc>().add(
      GetProductsEvent(
        queryParameters: ProductQueryParameters(categoryId: categoryId),
      ),
    );
  }
}
