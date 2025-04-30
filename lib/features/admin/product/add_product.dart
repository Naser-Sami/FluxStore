import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TPadding, TSize, TextFormFieldComponent;
import '/core/_core.dart' show BuildContextExtensions, TFunctions, errorDialog;
import '/features/_features.dart'
    show
        AddProductEvent,
        AddProductParams,
        CategoryBloc,
        CategoryState,
        ProductLoaded,
        ProductsBloc,
        ProductsError,
        ProductsLoaded,
        ProductsLoading,
        ProductsState;
import 'product_colors.dart';
import 'product_sizes.dart';

class AdminAddProductScreen extends StatefulWidget {
  static const routeName = '/admin-add-product';
  static const name = 'Add Product';
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

  final _selectedColors = <Color>[];
  List<String> _selectedSizes = [];

  File? _mainImage;
  final List<File> _subImages = [];

  String? _selectedCategoryId;

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
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsError) {
          errorDialog(context, message: state.message);
        }
        if (state is ProductsLoaded) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Product')),
        body: BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) async {
            if (state is ProductLoaded) {
              //
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(TPadding.p24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    height: context.screenHeight,
                    width: context.screenWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormFieldComponent(
                            controller: _nameController,
                            labelText: 'Name',
                          ),
                          const SizedBox(height: TSize.s24),
                          TextFormFieldComponent(
                            controller: _descriptionController,
                            labelText: 'Description',
                            minLines: 3,
                            maxLines: 8,
                          ),
                          const SizedBox(height: TSize.s24),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldComponent(
                                  controller: _priceController,
                                  labelText: 'Price',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: TSize.s36),
                              Expanded(
                                child: TextFormFieldComponent(
                                  controller: _stockController,
                                  labelText: 'Stock',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: TSize.s24),
                          BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              if (state.isSuccess) {
                                return DropdownButtonFormField<String>(
                                  hint: const Text('Select Category'),
                                  value: _selectedCategoryId,
                                  items:
                                      state.categories
                                          .map(
                                            (category) => DropdownMenuItem(
                                              value: category.id,
                                              child: Text(category.name),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    _selectedCategoryId = val;
                                  },
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: TSize.s24),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final color =
                                      await showModalBottomSheet<Color>(
                                        context: context,
                                        builder:
                                            (context) => const ProductColors(),
                                      );
                                  if (color != null) {
                                    setState(() {
                                      _selectedColors.add(color);
                                    });
                                  }
                                },
                                icon: const Icon(Icons.color_lens_rounded),
                              ),
                              const SizedBox(width: 24),

                              Expanded(
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (var color in _selectedColors)
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: color,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: TSize.s24),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final sizes =
                                      await showModalBottomSheet<List<String>>(
                                        context: context,
                                        builder:
                                            (context) => const ProductSizes(),
                                      );
                                  if (sizes != null && sizes.isNotEmpty) {
                                    setState(() {
                                      _selectedSizes = sizes;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.format_size_rounded),
                              ),
                              const SizedBox(width: TSize.s24),
                              Expanded(
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (var size in _selectedSizes)
                                      Chip(label: Text(size)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: TSize.s24),
                            ],
                          ),
                          const SizedBox(height: TSize.s24),
                          // Main Image Upload
                          Text(
                            'Main Product Image',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: GestureDetector(
                              onTap: () async {
                                final file =
                                    await TFunctions.pickAndUploadProfileImage(
                                      context,
                                    );
                                if (file != null) {
                                  setState(() {
                                    _mainImage = file;
                                  });
                                }
                              },
                              child:
                                  _mainImage != null
                                      ? Image.file(
                                        _mainImage!,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                      : Container(
                                        width: double.infinity,
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                            ),
                          ),
                          const SizedBox(height: TSize.s24),
                          // Sub Images Upload
                          Text(
                            'Product Details Images',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (var image in _subImages)
                                Stack(
                                  children: [
                                    Image.file(
                                      image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _subImages.remove(image);
                                          });
                                        },
                                        child: Container(
                                          color: Colors.black54,
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              GestureDetector(
                                onTap: () async {
                                  final file =
                                      await TFunctions.pickAndUploadProfileImage(
                                        context,
                                      );
                                  if (file != null) {
                                    setState(() {
                                      _subImages.add(file);
                                    });
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: const Center(child: Icon(Icons.add)),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: TSize.s64),
                          Padding(
                            padding: const EdgeInsets.all(TPadding.p24),
                            child: ElevatedButton(
                              onPressed: _addProduct,
                              child: const Text('Add Product'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
