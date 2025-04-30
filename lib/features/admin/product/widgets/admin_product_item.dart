import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show CachedNetWorkImageComponent;
import '/core/_core.dart' show ApiEndpoints;
import '/features/_features.dart' show AdminProductsScreen;
import '/features/admin/product/screen/sub_screens/_sub_screens.dart'
    show UpdateProductScreen;
import '/features/product/_product.dart';
import '_widgets.dart';

class AdminProductItemWidget extends StatelessWidget {
  const AdminProductItemWidget({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: products.length,
      onReorder: (oldIndex, newIndex) {
        // setState(() {
        //   if (newIndex > oldIndex) {
        //     newIndex -= 1;
        //   }
        //   final item = products.removeAt(oldIndex);
        //   products.insert(newIndex, item);
        // });
      },
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          key: ValueKey(product.id),
          leading: SizedBox(
            width: 50,
            height: 50,
            child: CachedNetWorkImageComponent(
              imageUrl: ApiEndpoints.imageUrl + product.imageUrl,
            ),
          ),
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.push(
                    AdminProductsScreen.routeName +
                        UpdateProductScreen.routeName,
                    extra: {'productId': product.id},
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed:
                    () => confirmDeleteProductDelete(context, product.id),
              ),
              const Icon(Icons.drag_handle),
            ],
          ),
        );
      },
    );
  }
}
