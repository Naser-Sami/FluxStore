import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/shared/_shared.dart';
import '/core/_core.dart' show ApiEndpoints, BuildContextExtensions, TFunctions;
import '/features/admin/_admin.dart' show ProductImage, ProductMainImageCubit;

class AdminProductMainImageWidget extends StatelessWidget {
  const AdminProductMainImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Column(
      children: [
        Text(
          'Main Product Image',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),

        SizedBox(
          width: 100,
          height: 100,
          child: OnTapScaler(
            onTap: () => _onImageTapped(context),
            child: BlocBuilder<ProductMainImageCubit, ProductImage>(
              builder: (BuildContext context, state) {
                if (state.isFile) {
                  return Image.file(
                    state.file!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                } else if (state.isUrl) {
                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: CachedNetWorkImageComponent(
                      imageUrl: ApiEndpoints.imageUrl + state.url!,
                    ),
                  );
                }

                return Container(
                  width: double.infinity,
                  height: 200,
                  color: color.surfaceContainerHigh,
                  child: const Center(child: Icon(Icons.add_a_photo, size: 40)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onImageTapped(BuildContext context) async {
    final file = await TFunctions.pickImage(context);
    if (file != null) {
      if (context.mounted) {
        context.read<ProductMainImageCubit>().setImageFile(file);
      }
    }
  }
}
