import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show errorDialog;
import '/features/_features.dart'
    show
        AddProductEvent,
        AddProductParams,
        GetProductDetailsEvent,
        ProductDetails,
        ProductDetailsBloc,
        ProductDetailsError,
        ProductDetailsLoaded,
        ProductDetailsState,
        ProductsBloc,
        ProductsError,
        ProductsLoaded,
        ProductsState;

class AdminAddProductScreen extends StatefulWidget {
  static const routeName = '/admin-add-product';
  static const name = 'Add Product';
  const AdminAddProductScreen({super.key, this.productId});

  final String? productId;

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  final _selectedColors = <String>[];
  final List<String> _selectedSizes = [];

  File? _mainImage;
  final List<File> _subImages = [];

  String? _selectedCategoryId;

  @override
  initState() {
    super.initState();
    if (widget.productId != null) _getProductDetails();
  }

  Future<void> _getProductDetails() async {
    context.read<ProductDetailsBloc>().add(
      GetProductDetailsEvent(widget.productId!),
    );
  }

  Future<void> _setProductData(ProductDetails product) async {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();
    _stockController.text = product.stock.toString();
    _selectedCategoryId = product.categoryId;
    _selectedColors.addAll(product.availableColors);
    _selectedSizes.addAll(product.availableSizes);
    _mainImage = File(product.imageUrl);
    _subImages.addAll(product.additionalImages.map(File.new).toList());
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate() && _mainImage != null) {
      //
    }
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate() && _mainImage != null) {
      final params = AddProductParams(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        image: _mainImage!, // file
        categoryId: _selectedCategoryId ?? '',
        additionalImages: _subImages, // files
        availableColors: _selectedColors.map((e) => e.toString()).toList(),
        availableSizes: _selectedSizes.map((e) => e.toString()).toList(),
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
    if (widget.productId != null) {
      return BlocListener<ProductDetailsBloc, ProductDetailsState>(
        listener: (context, state) async {
          if (state is ProductDetailsError) {
            errorDialog(context, message: state.message);
          }
          if (state is ProductDetailsLoaded) {
            await _setProductData(state.productDetails);
          }
        },
      );
    }

    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsError) {
          errorDialog(context, message: state.message);
        }
        if (state is ProductsLoaded) {
          context.pop();
        }
      },
    );
  }
}
