import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart'
    show ProductQueryParameters, ProductsSlider, SearchResultScreen;

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: SearchAnchor.bar(
              isFullScreen: true,
              barElevation: const WidgetStatePropertyAll(4),
              barBackgroundColor: WidgetStatePropertyAll(
                color.surfaceContainer,
              ),
              barShape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TRadius.r16),
                ),
              ),
              viewShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TRadius.r16),
              ),
              onChanged: (query) {
                // log('query: $query');
              },
              onSubmitted: (query) {
                ProductQueryParameters? queryParameters =
                    ProductQueryParameters(search: query);

                context.push(
                  SearchResultScreen.routeName,
                  extra: queryParameters,
                );
              },
              suggestionsBuilder: (context, searchController) {
                return [
                  const SizedBox(height: TSize.s24),
                  Padding(
                    padding: const EdgeInsets.all(TPadding.p16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          'Recent Searches',
                          style: context.textTheme.titleMedium,
                        ),
                        OnTapScaler(
                          onTap: () {},
                          child: const Icon(CupertinoIcons.delete),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(TPadding.p16),
                    child: Wrap(
                      spacing: TSize.s08,
                      runSpacing: TSize.s08,
                      children: [
                        Chip(label: const Text('Shoes'), onDeleted: () {}),
                        Chip(label: const Text('Clothes'), onDeleted: () {}),
                        Chip(
                          label: const Text('Accessories'),
                          onDeleted: () {},
                        ),
                        Chip(label: const Text('Bags'), onDeleted: () {}),
                        Chip(label: const Text('Watches'), onDeleted: () {}),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSize.s60),
                  const Padding(
                    padding: EdgeInsets.all(TPadding.p16),
                    child: ProductsSlider(title: 'Popular this week'),
                  ),
                  const SizedBox(height: TSize.s60),
                ];
              },
            ),
          ),
          const SizedBox(width: TPadding.p16),
          OnTapScaler(
            onTap: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(TRadius.r16),
              child: Container(
                width: 55,
                height: 55,
                padding: const EdgeInsets.all(TPadding.p12),
                decoration: BoxDecoration(
                  color: color.surfaceContainer,
                  borderRadius: BorderRadius.circular(TRadius.r16),
                  boxShadow: [
                    BoxShadow(
                      color: color.shadow.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const IconWidget(name: 'filter'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
