import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show TPadding, TSize;
import '/features/_features.dart'
    show
        GetProductDetailsEvent,
        ProductDetails,
        ProductDetailsBloc,
        ProductDetailsLoaded,
        ProductDetailsState;
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

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getProductDetails();
  }

  Future<void> _getProductDetails() async {
    context.read<ProductDetailsBloc>().add(
      GetProductDetailsEvent(widget.productId),
    );
  }

  void _setProductData() {
    final dropDownCubit = context.read<ProductCategoryDropdownCubit>();
    final colorsCubit = context.read<ProductColorsCubit>();
    final sizesCubit = context.read<ProductSizesCubit>();
    final mainImageCubit = context.read<ProductMainImageCubit>();
    final subImagesCubit = context.read<ProductSubImagesCubit>();

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
    return BlocListener<ProductDetailsBloc, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsLoaded) {
          product = state.productDetails;
          _setProductData();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Product')),
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

                  // Product Sizes
                  const AdminProductSizeWidget(),

                  // Product Main Image
                  const AdminProductMainImageWidget(),

                  // Product Sub Images
                  const AdminProductSubImagesWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
