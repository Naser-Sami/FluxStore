import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/shared/_shared.dart';
import '/core/_core.dart' show ApiEndpoints, BuildContextExtensions, TFunctions;
import '/features/admin/_admin.dart' show ProductImage, ProductSubImagesCubit;

class AdminProductSubImagesWidget extends StatelessWidget {
  const AdminProductSubImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Column(
      children: [
        Text(
          'Product Details Images',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        BlocBuilder<ProductSubImagesCubit, List<ProductImage>>(
          builder: (context, state) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var image in state)
                  Stack(
                    children: [
                      if (image.isFile)
                        Image.file(
                          image.file!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      else if (image.isUrl)
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CachedNetWorkImageComponent(
                            imageUrl: ApiEndpoints.imageUrl + image.url!,
                          ),
                        ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _onImageRemoved(context, image),
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
                OnTapScaler(
                  onTap: () => _onImageTapped(context),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: color.surfaceContainerHigh,
                    child: const Center(child: Icon(Icons.add)),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _onImageTapped(BuildContext context) async {
    final file = await TFunctions.pickImage(context);
    if (file != null && context.mounted) {
      context.read<ProductSubImagesCubit>().addFile(file);
    }
  }

  void _onImageRemoved(BuildContext context, ProductImage image) {
    if (context.mounted) {
      context.read<ProductSubImagesCubit>().removeImage(image);
    }
  }
}
