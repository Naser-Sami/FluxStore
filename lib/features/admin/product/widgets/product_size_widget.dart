import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show TSize;
import '/features/admin/_admin.dart' show ProductSizesCubit;
import 'product_sizes.dart';

class AdminProductSizeWidget extends StatelessWidget {
  const AdminProductSizeWidget({super.key});

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
              if (context.mounted) {
                context.read<ProductSizesCubit>().setSizes(sizes);
              }
            }
          },
          icon: const Icon(Icons.format_size_rounded),
        ),
        const SizedBox(width: TSize.s24),
        Expanded(
          child: BlocBuilder<ProductSizesCubit, List<String>>(
            builder: (context, state) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [for (var size in state) Chip(label: Text(size))],
              );
            },
          ),
        ),
        const SizedBox(height: TSize.s24),
      ],
    );
  }
}
