import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show CachedNetWorkImageComponent;
import '/core/_core.dart' show ApiEndpoints;
import '/features/_features.dart'
    show
        AdminAddProductScreen,
        DeleteProductEvent,
        ProductsBloc,
        ProductsError,
        ProductsLoaded,
        ProductsLoading,
        ProductsState;

class AdminProductScreen extends StatefulWidget {
  static const String routeName = '/product';
  static const String name = 'Product';
  const AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            AdminProductScreen.routeName + AdminAddProductScreen.routeName,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductsError) {
                return Center(child: Text(state.message));
              }
              if (state is ProductsLoaded) {
                return ReorderableListView.builder(
                  itemCount: state.products.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = state.products.removeAt(oldIndex);
                      state.products.insert(newIndex, item);
                    });
                  },
                  itemBuilder: (context, index) {
                    final product = state.products[index];
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
                              // Edit product
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _confirmDelete(product.id);
                            },
                          ),
                          const Icon(Icons.drag_handle),
                        ],
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void _confirmDelete(String productId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Product'),
            content: const Text(
              'Are you sure you want to delete this product?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<ProductsBloc>().add(
                    DeleteProductEvent(productId),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
