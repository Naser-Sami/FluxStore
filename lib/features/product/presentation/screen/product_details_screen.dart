import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart'
    show
        GetProductDetailsEvent,
        ProductDetailsBloc,
        ProductDetailsBodyWidget,
        ProductDetailsError,
        ProductDetailsLoaded,
        ProductDetailsLoading,
        ProductDetailsState;

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/details';
  static const String name = 'Product Details';
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    context.read<ProductDetailsBloc>().add(
      GetProductDetailsEvent(widget.productId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          switch (state) {
            case ProductDetailsLoading():
              return const Center(child: CircularProgressIndicator());

            case ProductDetailsLoaded():
              final details = state.productDetails;

              return ProductDetailsBodyWidget(details: details);

            case ProductDetailsError():
              return Center(child: Text(state.message));

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
