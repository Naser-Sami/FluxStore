import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

import '/config/_config.dart' show TSize, TextFormFieldComponent;

class AdminProductFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController stockController;

  const AdminProductFormWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    required this.stockController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Product Name
          TextFormFieldComponent(controller: nameController, labelText: 'Name'),
          const SizedBox(height: TSize.s24),

          // Product Description
          TextFormFieldComponent(
            controller: descriptionController,
            labelText: 'Description',
            minLines: 3,
            maxLines: 8,
          ),
          const SizedBox(height: TSize.s24),

          // Product Price and Stock
          Row(
            children: [
              Expanded(
                child: TextFormFieldComponent(
                  controller: priceController,
                  labelText: 'Price',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                ),
              ),
              const SizedBox(width: TSize.s36),
              Expanded(
                child: TextFormFieldComponent(
                  controller: stockController,
                  labelText: 'Stock',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
