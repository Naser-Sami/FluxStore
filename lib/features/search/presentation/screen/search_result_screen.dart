import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show CachedNetWorkImageComponent, OnTapScaler, TPadding, TSize, TextWidget;
import '/config/theme/_theme.dart';
import '/core/_core.dart' show ApiEndpoints, scaffoldKey;
import '/core/utils/_utils.dart';
import '/features/_features.dart'
    show
        GetProductsEvent,
        ProductDetailsScreen,
        ProductQueryParameters,
        ProductsBloc,
        ProductsLoaded,
        ProductsLoading,
        ProductsState;

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/search-result';
  static const String name = 'Search Result';
  const SearchResultScreen({super.key, required this.query});

  final ProductQueryParameters? query;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    _getSearchResults();
  }

  Future<void> _getSearchResults() async {
    context.read<ProductsBloc>().add(
      GetProductsEvent(queryParameters: widget.query),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextWidget(widget.query?.search?.toTitleCase ?? ''),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsLoaded) {
            final color = context.theme.colorScheme;

            return Padding(
              padding: const EdgeInsets.all(TPadding.p24),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 65,
                        child: TextWidget(
                          'Found\n${state.products.length} Results',
                          style: context.textTheme.headlineMedium,
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: OnTapScaler(
                          onTap:
                              () => scaffoldKey.currentState?.openEndDrawer(),
                          child: Container(
                            padding: const EdgeInsets.all(TPadding.p12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.theme.colorScheme.outline
                                    .withValues(alpha: 0.3),
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(TRadius.r60),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextWidget(
                                  'Filters',
                                  style: context.textTheme.titleMedium,
                                ),
                                const SizedBox(width: TSize.s04),
                                const Icon(
                                  CupertinoIcons.color_filter,
                                  size: TSize.s20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSize.s34),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          mainAxisSpacing: TSize.s30,
                          crossAxisSpacing: TSize.s30,
                        ),

                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: OnTapScaler(
                              onTap: () {
                                context.push(
                                  ProductDetailsScreen.routeName,
                                  extra: {'productId': product.id},
                                );
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      TRadius.r12,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ColoredBox(
                                        color: color.surfaceContainerHighest,
                                        child: CachedNetWorkImageComponent(
                                          imageUrl:
                                              ApiEndpoints.imageUrl +
                                              product.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    top: 10,
                                    end: 10,
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: color.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(
                                          TRadius.r60,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: color.scrim.withValues(
                                              alpha: 0.1,
                                            ),
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                            offset: const Offset(-1, 3),
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: TSize.s14),
                          Text(
                            product.name,
                            maxLines: 1,
                            style: context.textTheme.titleMedium,
                          ),
                          const SizedBox(height: TSize.s04),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: product.price
                                      .toString()
                                      .toCurrencyString(symbol: '\$'),
                                  style: context.textTheme.titleMedium,
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: (product.price + 10)
                                      .toString()
                                      .toCurrencyString(symbol: '\$'),
                                  style: context.textTheme.titleSmall?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: color.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSize.s04),
                          // Rating
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        const Icon(Icons.star, size: TSize.s16),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      for (int i = 0; i < 3; i++)
                                        Icon(
                                          Icons.star,
                                          color: color.primary,
                                          size: TSize.s16,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    const TextSpan(text: '('),
                                    const TextSpan(text: '45'),
                                    const TextSpan(text: ')'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
