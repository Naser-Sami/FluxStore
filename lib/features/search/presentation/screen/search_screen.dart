import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/_features.dart'
    show DiscoverCollectionBaseExpansionTile, SearchBarWidget;

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  static const String name = 'Search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: ListView(
            children: [
              const SearchBarWidget(),
              const SizedBox(height: TSize.s28),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return DiscoverCollectionBaseExpansionTile(
                      children: [
                        ExpansionTile(
                          key: UniqueKey(),
                          childrenPadding: const EdgeInsetsDirectional.only(
                            start: TPadding.p24,
                          ),
                          title: const ListTile(
                            title: TextWidget('Jackets'),
                            trailing: TextWidget('128 items'),
                          ),
                          children: [
                            ExpansionTile(
                              key: UniqueKey(),
                              title: const ListTile(
                                title: TextWidget('Jeans'),
                                trailing: TextWidget('14 items'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
