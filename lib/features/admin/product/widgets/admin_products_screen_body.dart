import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/product/_product.dart';
import 'admin_product_item.dart';

class AdminProductsScreenBodyWidget extends StatelessWidget {
  const AdminProductsScreenBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              // create a nice shimmer effect loading
            }

            if (state is ProductsError) {
              // create a nice error ui
            }

            if (state is ProductsLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return AdminProductItemWidget(product: product);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
