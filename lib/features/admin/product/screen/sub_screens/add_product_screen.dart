import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TSize;
import '/features/admin/product/widgets/_widgets.dart';

class AdminAddProductScreen extends StatefulWidget {
  static const routeName = '/admin-add-product';
  static const name = 'Admin Add Product';
  const AdminAddProductScreen({super.key});

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            child: Column(
              spacing: TSize.s24,
              children: [
                // Product Form
                AdminProductFormWidget(
                  formKey: _formKey,
                  nameController: _nameController,
                  descriptionController: _descriptionController,
                  priceController: _priceController,
                  stockController: _stockController,
                ),

                // Category Dropdown
                const ProductCategoriesDropdownWidget(),

                // Product Colors
                const AdminProductColorsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
