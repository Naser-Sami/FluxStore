import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart'
    show
        TitleWithShowAll,
        ProductsLoading,
        ProductsLoaded,
        ProductsError,
        Product,
        ProductsBloc,
        ProductsState;
import 'product_item.dart';

class ProductsSlider extends StatelessWidget {
  const ProductsSlider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        switch (state) {
          case ProductsLoading():
            return const Center(child: CircularProgressIndicator());
          case ProductsLoaded():
            return ProductSliderBody(title: title, products: state.products);
          case ProductsError():
            return Center(child: TextWidget(state.message));
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class ProductSliderBody extends StatelessWidget {
  const ProductSliderBody({
    super.key,
    required this.title,
    required this.products,
  });
  final String title;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final textTheme = context.theme.textTheme;

    return Column(
      children: [
        TitleWithShowAll(title: title, onShowAll: () {}),
        const SizedBox(height: TSize.s20),
        SizedBox(
          height: 287,
          child: ListView.separated(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder:
                (context, index) => const SizedBox(width: TSize.s10),
            itemBuilder: (context, index) {
              final bool paddingOnFirst = index == 0;
              final bool paddingOnLast = index == products.length - 1;
              final product = products[index];

              return Padding(
                padding: EdgeInsets.only(
                  left: paddingOnFirst ? TPadding.p24 : 0,
                  right: paddingOnLast ? TSize.s24 : 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductItem(
                      index: index,
                      controller: controller,
                      product: product,
                    ),
                    const SizedBox(height: TSize.s14),
                    TextWidget(
                      product.name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextWidget(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ).scaleAnimation(scaleBegin: const Offset(1.3, 1.3)),
      ],
    );
  }
}
