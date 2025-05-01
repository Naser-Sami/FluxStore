import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TPadding, TSize;
import '/features/_features.dart'
    show
        AddProductEvent,
        AddProductParams,
        AdminProductsScreen,
        ProductsBloc,
        ProductsLoaded,
        ProductsState;
import '/features/admin/_admin.dart'
    show
        ProductCategoryDropdownCubit,
        ProductColorsCubit,
        ProductMainImageCubit,
        ProductSizesCubit,
        ProductSubImagesCubit;
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

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final dropDownCubit = context.read<ProductCategoryDropdownCubit>();
      final colorsCubit = context.read<ProductColorsCubit>();
      final sizesCubit = context.read<ProductSizesCubit>();
      final mainImageCubit = context.read<ProductMainImageCubit>();
      final subImagesCubit = context.read<ProductSubImagesCubit>();

      final params = AddProductParams(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        categoryId: dropDownCubit.state,
        availableColors: colorsCubit.state.map((e) => e.toString()).toList(),
        availableSizes: sizesCubit.state.map((e) => e.toString()).toList(),
        image: mainImageCubit.state.file!,
        additionalImages: subImagesCubit.state.map((e) => e.file!).toList(),
      );

      context.read<ProductsBloc>().add(AddProductEvent(params));
    }
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
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsLoaded) {
          context.go(AdminProductsScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Product')),
        body: SafeArea(
          child: Padding(
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

                    // Product Sizes
                    const AdminProductSizeWidget(),

                    // Product Main Image
                    const AdminProductMainImageWidget(),

                    // Product Sub Images
                    const AdminProductSubImagesWidget(),

                    // Spacing
                    const SizedBox(height: TSize.s12),

                    // Add Product Button
                    ElevatedButton(
                      onPressed: _addProduct,
                      child: const Text('Add Product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
