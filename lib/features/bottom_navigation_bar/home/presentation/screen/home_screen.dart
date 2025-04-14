import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart' show LocaleKeys, sl;
import '/features/_features.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollControllerProvider.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CategoryBloc>()..add(GetAllCategoryEvent()),
        ),
        BlocProvider(create: (context) => SelectedCategoryCubit()),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
