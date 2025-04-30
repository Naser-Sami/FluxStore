import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show BuildContextExtensions;
import '/features/product/_product.dart';

void confirmDeleteProductDelete(BuildContext context, String productId) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ProductsBloc>().add(DeleteProductEvent(productId));
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: context.theme.colorScheme.error),
              ),
            ),
          ],
        ),
  );
}
