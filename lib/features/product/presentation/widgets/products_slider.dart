import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show TextWidget;
import '/features/_features.dart'
    show
        ProductsBloc,
        ProductsError,
        ProductsLoaded,
        ProductsLoading,
        ProductsState;
import 'products_slider_body.dart';

class ProductsSlider extends StatelessWidget {
  const ProductsSlider({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        switch (state) {
          case ProductsLoading():
            return const Center(child: CircularProgressIndicator());
          case ProductsLoaded():
            final products = state.products;

            return ProductSliderBody(title: title, products: products);

          case ProductsError():
            return Center(child: TextWidget(state.message));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
