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
              isScrollControlled: true,
              useSafeArea: true,
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
                          return SizedBox(
                            width: 34,
                            height: 34,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: color.toColor(),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap:
                                        () => _onColorRemoved(context, color),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          return GestureDetector(
                            onTap: () => _onColorRemoved(context, color),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          );
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

  void _onColorRemoved(BuildContext context, String color) {
    context.read<ProductColorsCubit>().removeColor(color);
  }
}
