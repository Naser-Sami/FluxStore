import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/features/_features.dart'
    show
        DiscoverCollectionBaseExpansionTile,
        MainAppBar,
        OnDrawerTapCubit,
        SearchBarWidget;
import '/generated/locale_keys.g.dart' show LocaleKeys;

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  static const String name = 'Search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onMenuPressed: () => _toggleDrawer(context),
        title: const TextWidget(LocaleKeys.DrawerMenu_discover),
      ),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(TPadding.p20),
            child: ListView(
              children: [
                const SearchBarWidget(),
                const SizedBox(height: TSize.s28),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return DiscoverCollectionBaseExpansionTile(
                      children: [
                        ExpansionTileWidget(
                          key: UniqueKey(),
                          showTrailingIcon: false,
                          childrenPadding: const EdgeInsetsDirectional.only(
                            start: TPadding.p24,
                          ),
                          title: const ListTile(
                            title: TextWidget('Jackets'),
                            trailing: TextWidget('128 items'),
                          ),
                          children: [
                            ExpansionTileWidget(
                              key: UniqueKey(),
                              showTrailingIcon: false,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDrawer(BuildContext context) {
    context.read<OnDrawerTapCubit>().toggleDrawer();
  }
}
