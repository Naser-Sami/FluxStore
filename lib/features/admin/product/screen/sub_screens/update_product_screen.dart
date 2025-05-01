import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TPadding, TSize;
import '/features/_features.dart'
    show
        AdminProductsScreen,
        GetProductDetailsEvent,
        ProductDetails,
        ProductDetailsBloc,
        ProductDetailsLoaded,
        ProductDetailsState,
        ProductsBloc,
        ProductsLoaded,
        ProductsState,
        UpdateProductEvent,
        UpdateProductParams;
import '/features/admin/_admin.dart'
    show
        ProductCategoryDropdownCubit,
        ProductColorsCubit,
        ProductMainImageCubit,
        ProductSizesCubit,
        ProductSubImagesCubit;
import '/features/admin/product/widgets/_widgets.dart';

class UpdateProductScreen extends StatefulWidget {
  static const routeName = '/update-product';
  static const name = 'Update Product';

  const UpdateProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late ProductDetails product;

  late ProductCategoryDropdownCubit dropDownCubit;
  late ProductColorsCubit colorsCubit;
  late ProductSizesCubit sizesCubit;
  late ProductMainImageCubit mainImageCubit;
  late ProductSubImagesCubit subImagesCubit;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeCubits();
    _getProductDetails();
  }

  Future<void> _getProductDetails() async {
    context.read<ProductDetailsBloc>().add(
      GetProductDetailsEvent(widget.productId),
    );
  }

  void initializeCubits() {
    dropDownCubit = context.read<ProductCategoryDropdownCubit>();
    colorsCubit = context.read<ProductColorsCubit>();
    sizesCubit = context.read<ProductSizesCubit>();
    mainImageCubit = context.read<ProductMainImageCubit>();
    subImagesCubit = context.read<ProductSubImagesCubit>();
  }

  void _setProductData() {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();
    _stockController.text = product.stock.toString();
    dropDownCubit.setSelectedCategoryId(product.categoryId);
    colorsCubit.setColors(product.availableColors);
    sizesCubit.setSizes(product.availableSizes);
    mainImageCubit.setImageUrl(product.imageUrl);
    subImagesCubit.clear();
    for (var url in product.additionalImages) {
      subImagesCubit.addUrl(url);
    }
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      final mainImage = mainImageCubit.state;

      final files =
          subImagesCubit.state
              .where((e) => e.isFile)
              .map((e) => e.file)
              .toList();

      final params = UpdateProductParams(
        id: widget.productId,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        categoryId: dropDownCubit.state,
        availableColors: colorsCubit.state.map((e) => e.toString()).toList(),
        availableSizes: sizesCubit.state.map((e) => e.toString()).toList(),

        // ✅ Send either file or the original URL
        imageUrl: mainImage.file,

        // ✅ Send both new files and existing URLs
        additionalImages: null,
      );

      context.read<ProductsBloc>().add(UpdateProductEvent(params));
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
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state is ProductDetailsLoaded) {
              product = state.productDetails;
              _setProductData();
            }
          },
        ),
        BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsLoaded) {
              context.go(AdminProductsScreen.routeName);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Product')),
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
                      onPressed: _updateProduct,
                      child: const Text('Update Product'),
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
