import 'package:flutter/material.dart';
import 'package:flux_store/config/_config.dart'
    show CustomButton, TPadding, TSize, TextFormFieldComponent;
import 'package:flux_store/core/_core.dart' show BuildContextExtensions;

class AddEditCategoryBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController categoryName;
  final TextEditingController categoryDescription;
  final TextEditingController categoryImageUrl;
  final VoidCallback onTap;
  final String buttonTitle;

  const AddEditCategoryBody({
    super.key,
    required this.formKey,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryImageUrl,
    required this.onTap,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(TPadding.p24),
        child: Column(
          children: [
            TextFormFieldComponent(
              hintText: 'Category Name',
              labelText: 'Category Name',
              controller: categoryName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null;
              },
            ),
            const SizedBox(height: TSize.s16),
            TextFormFieldComponent(
              hintText: 'Category Description',
              labelText: 'Category Description',
              controller: categoryDescription,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category description';
                }
                return null;
              },
            ),
            const SizedBox(height: TSize.s16),
            TextFormFieldComponent(
              hintText: 'Category Image URL',
              labelText: 'Category Image URL',
              controller: categoryImageUrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category image url';
                }
                return null;
              },
            ),
            const SizedBox(height: TSize.s24),
            CustomButton(
              backgroundColor: context.theme.colorScheme.primary,
              onTap: onTap,
              text: buttonTitle,
            ),
          ],
        ),
      ),
    );
  }
}
