import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show CachedNetWorkImageComponent, TRadius;
import '/core/_core.dart' show ApiEndpoints;
import '/features/_features.dart' show AdminProductsScreen;
import '/features/admin/product/screen/sub_screens/_sub_screens.dart'
    show UpdateProductScreen;
import '/features/product/_product.dart';
import '_widgets.dart';

class AdminProductItemWidget extends StatelessWidget {
  const AdminProductItemWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(product.id),
      onTap: () => _onEdit(context, product.id),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(TRadius.r08),
        child: SizedBox(
          width: 50,
          height: 50,
          child: CachedNetWorkImageComponent(
            imageUrl: ApiEndpoints.imageUrl + product.imageUrl,
          ),
        ),
      ),
      title: Text(product.name),
      subtitle: Text('\$${product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _onEdit(context, product.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => confirmDeleteProductDelete(context, product.id),
          ),
        ],
      ),
    );
  }

  void _onEdit(BuildContext context, String productId) {
    context.push(
      AdminProductsScreen.routeName + UpdateProductScreen.routeName,
      extra: {'productId': productId},
    );
  }
}
