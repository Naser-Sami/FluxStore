import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart' show LocaleKeys;
import '/features/_features.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollControllerProvider.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: const Column(
          spacing: TSize.s30,
          mainAxisSize: MainAxisSize.max,
          children: [
            CategoriesList(),
            CollectionsSliderBanner(),
            ProductsSlider(title: LocaleKeys.Product_featureProducts),
            NewCollectionBanner(),
            RecommendedProducts(),
            TopCollections(),
            SizedBox(height: TSize.s36),
          ],
        ),
      ),
    );
  }
}
