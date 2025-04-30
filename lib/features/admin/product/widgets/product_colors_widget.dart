import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show HexColorExtension;
import '/features/admin/_admin.dart' show ProductColorsCubit;
import 'product_color_picker_widget.dart';

class AdminProductColorsWidget extends StatelessWidget {
  const AdminProductColorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final color = await showModalBottomSheet<String>(
              context: context,
              builder: (context) => const ProductColorPickerWidget(),
            );
            if (color != null) {
              if (context.mounted) {
                context.read<ProductColorsCubit>().addColor(color);
              }
            }
          },
          icon: const Icon(Icons.color_lens_rounded),
        ),
        const SizedBox(width: 24),

        Expanded(
          child: BlocBuilder<ProductColorsCubit, List<String>>(
            builder: (context, state) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var color in state)
                    Builder(
                      builder: (context) {
                        try {
                          return Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: color.toColor(),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black12),
                            ),
                          );
                        } catch (e) {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
