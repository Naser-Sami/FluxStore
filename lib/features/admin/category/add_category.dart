import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show errorDialog, showLoadingDialog, successDialog;
import '/features/_features.dart'
    show
        AddEditCategoryBody,
        CategoryBloc,
        CategoryState,
        CreateCategoryEvent,
        CreateCategoryParams;

class AddCategoryScreen extends StatefulWidget {
  static const String routeName = '/add-category';
  static const String name = 'Add Category';
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _categoryName = TextEditingController();
  final _categoryDescription = TextEditingController();
  final _categoryImageUrl = TextEditingController();

  Future<void> _createCategory() async {
    if (_formKey.currentState!.validate()) {
      final params = CreateCategoryParams(
        name: _categoryName.text,
        description: _categoryDescription.text,
        imageUrl: _categoryImageUrl.text,
      );

      context.read<CategoryBloc>().add(CreateCategoryEvent(params: params));
    }
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
      appBar: AppBar(title: const Text('Add Category')),
      body: Builder(
        builder: (context) {
          return BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state.isLoading) {
                if (!mounted) return;
                showLoadingDialog(context);
                context.pop();
              }

              if (state.isError) {
                errorDialog(context, message: 'Failed to create category');
                return;
              }

              if (state.isSuccess) {
                successDialog(
                  context,
                  message: 'Category created successfully',
                  onPressed: () {
                    _categoryName.clear();
                    _categoryDescription.clear();
                    _categoryImageUrl.clear();
                    context.pop();
                  },
                );

                return;
              }
            },
            child: AddEditCategoryBody(
              formKey: _formKey,
              categoryName: _categoryName,
              categoryDescription: _categoryDescription,
              categoryImageUrl: _categoryImageUrl,
              onTap: _createCategory,
              buttonTitle: 'Create Category',
            ),
          );
        },
      ),
    );
  }
}
