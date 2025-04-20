import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show ExpansionTileWidget, IconWidget, TPadding, ThemeCubit;
import '/core/_core.dart';
import '/features/_features.dart'
    show
        AddCategoryScreen,
        AddEditCategoryBody,
        AdminScreen,
        CategoryBloc,
        CategoryState,
        DeleteCategoryEvent,
        GetAllCategoryEvent,
        UpdateCategoryEvent,
        UpdateCategoryParams;

class AdminCategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  static const String name = 'Category';
  const AdminCategoryScreen({super.key});

  @override
  State<AdminCategoryScreen> createState() => _AdminCategoryScreenState();
}

class _AdminCategoryScreenState extends State<AdminCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _categoryName = TextEditingController();
  final _categoryDescription = TextEditingController();
  final _categoryImageUrl = TextEditingController();

  @override
  void initState() {
    context.read<CategoryBloc>().add(GetAllCategoryEvent());
    super.initState();
  }

  void _updateCategory(UpdateCategoryParams params) {
    if (_formKey.currentState!.validate()) {
      context.read<CategoryBloc>().add(UpdateCategoryEvent(params: params));
    }
  }

  void _deleteCategory(String id) {
    context.read<CategoryBloc>().add(DeleteCategoryEvent(id: id));
  }

  @override
  void dispose() {
    _categoryName.dispose();
    _categoryDescription.dispose();
    _categoryImageUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Category'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(AdminScreen.routeName + AddCategoryScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isError) {
            return const Center(child: Text('Something went wrong!'));
          }

          if (state.isSuccess) {
            return Padding(
              padding: const EdgeInsets.all(TPadding.p24),
              child: ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];

                  return ExpansionTileWidget(
                    trailing: IconButton(
                      onPressed: () => _deleteCategory(category.id),
                      icon: const Icon(Icons.delete_forever_rounded),
                    ),
                    title: BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, state) {
                        return ListTile(
                          leading: IconWidget(
                            name: category.imageUrl,
                            color: context.theme.colorScheme.onSurface,
                            width: 20,
                            height: 20,
                          ),
                          title: Text(
                            category.name,
                            style: context.textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            category.description,
                            style: context.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                    children: [
                      Builder(
                        builder: (context) {
                          _categoryName.text = category.name;
                          _categoryDescription.text = category.description;
                          _categoryImageUrl.text = category.imageUrl;

                          return AddEditCategoryBody(
                            formKey: _formKey,
                            categoryName: _categoryName,
                            categoryDescription: _categoryDescription,
                            categoryImageUrl: _categoryImageUrl,
                            onTap:
                                () async => _updateCategory(
                                  UpdateCategoryParams(
                                    id: category.id,
                                    name: _categoryName.text.trim(),
                                    description:
                                        _categoryDescription.text.trim(),
                                    imageUrl: _categoryImageUrl.text.trim(),
                                    updatedAt: DateTime.now(),
                                  ),
                                ),
                            buttonTitle: 'Update Category',
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
