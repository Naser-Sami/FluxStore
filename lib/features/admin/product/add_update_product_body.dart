import 'dart:io';

import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TSize;
import '/core/_core.dart' show BuildContextExtensions, TFunctions;
import 'product_sizes.dart';

class AddUpdateProductBody extends StatelessWidget {
  AddUpdateProductBody({
    super.key,
    this.onPressed,
    required this.selectedColors,
    required this.selectedSizes,
    this.mainImage,
    required this.subImages,
  });

  final void Function()? onPressed;

  final List<String> selectedColors;
  final List<String> selectedSizes;

  final File? mainImage;
  final List<File> subImages;
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    print('Product Image = $mainImage');

    return Padding(
      padding: const EdgeInsets.all(TPadding.p24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SizedBox(
            height: context.screenHeight,
            width: context.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///
                  ///
                  const SizedBox(height: TSize.s24),
                  _ProductSized(selectedSizes: selectedSizes),
                  const SizedBox(height: TSize.s24),

                  ///
                  ///
                  // Main Image Upload
                  Text(
                    'Main Product Image',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _ProductImage(mainImage: mainImage),
                  const SizedBox(height: TSize.s24),
                  // Sub Images Upload
                  Text(
                    'Product Details Images',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _ProductImages(subImages: subImages),

                  const SizedBox(height: TSize.s64),
                  Padding(
                    padding: const EdgeInsets.all(TPadding.p24),
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: const Text('Add Product'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductSized extends StatefulWidget {
  _ProductSized({required this.selectedSizes});

  List<String> selectedSizes;

  @override
  State<_ProductSized> createState() => __ProductSizedState();
}

class __ProductSizedState extends State<_ProductSized> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final sizes = await showModalBottomSheet<List<String>>(
              context: context,
              builder: (context) => const ProductSizes(),
            );
            if (sizes != null && sizes.isNotEmpty) {
              setState(() {
                widget.selectedSizes = sizes;
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
              for (var size in widget.selectedSizes) Chip(label: Text(size)),
            ],
          ),
        ),
        const SizedBox(height: TSize.s24),
      ],
    );
  }
}

class _ProductImage extends StatefulWidget {
  _ProductImage({required this.mainImage});

  File? mainImage;

  @override
  State<_ProductImage> createState() => __ProductImageState();
}

class __ProductImageState extends State<_ProductImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: GestureDetector(
        onTap: () async {
          final file = await TFunctions.pickAndUploadProfileImage(context);
          if (file != null) {
            setState(() {
              widget.mainImage = file;
            });
          }
        },
        child:
            widget.mainImage != null
                ? Image.file(
                  widget.mainImage!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
                : Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.add_a_photo, size: 40)),
                ),
      ),
    );
  }
}

class _ProductImages extends StatefulWidget {
  const _ProductImages({required this.subImages});

  final List<File> subImages;

  @override
  State<_ProductImages> createState() => __ProductImagesState();
}

class __ProductImagesState extends State<_ProductImages> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var image in widget.subImages)
          Stack(
            children: [
              Image.file(image, width: 100, height: 100, fit: BoxFit.cover),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.subImages.remove(image);
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
            final file = await TFunctions.pickAndUploadProfileImage(context);
            if (file != null) {
              setState(() {
                widget.subImages.add(file);
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
    );
  }
}
