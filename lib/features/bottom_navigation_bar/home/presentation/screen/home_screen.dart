import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart' show sl;
import '/features/_features.dart'
    show
        CategoriesList,
        CategoryBloc,
        CollectionsSliderBanner,
        GetAllCategoryEvent,
        SelectedCategoryCubit;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CategoryBloc>()..add(GetAllCategoryEvent()),
        ),
        BlocProvider(create: (context) => SelectedCategoryCubit()),
      ],
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            const CategoriesList(),
            const SizedBox(height: TSize.s30),
            const CollectionsSliderBanner(),
            const SizedBox(height: TSize.s30),
          ],
        ),
      ),
    );
  }
}
