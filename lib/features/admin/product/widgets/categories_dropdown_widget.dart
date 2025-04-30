import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/admin/_admin.dart' show ProductCategoryDropdownCubit;
import '/features/category/_category.dart'
    show Category, CategoryBloc, CategoryState;

class ProductCategoriesDropdownWidget extends StatelessWidget {
  const ProductCategoriesDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.isSuccess) {
          return ProductCategoryDropdownWidget(categories: state.categories);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ProductCategoryDropdownWidget extends StatelessWidget {
  const ProductCategoryDropdownWidget({super.key, required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCategoryDropdownCubit, String>(
      builder: (context, state) {
        final cubit = context.read<ProductCategoryDropdownCubit>();

        state = state.isEmpty ? categories.first.id : state;

        return DropdownButtonFormField<String>(
          hint: const Text('Select Category'),
          value: state,
          items:
              categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
          onChanged: cubit.setSelectedCategoryId,
        );
      },
    );
  }
}
