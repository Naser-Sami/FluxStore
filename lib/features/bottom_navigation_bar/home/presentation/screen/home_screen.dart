import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart' show sl;
import '/features/_features.dart'
    show CategoriesList, CategoryBloc, GetAllCategoryEvent, HomeSliderBanner;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryBloc>()..add(GetAllCategoryEvent()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: TPadding.p32.r,
          ).copyWith(top: TPadding.p28.r),
          child: ListView(
            shrinkWrap: true,
            children: [
              const CategoriesList(),
              const SizedBox(height: TSize.s30),
              const HomeSliderBanner(),
              const SizedBox(height: TSize.s30),
            ],
          ),
        ),
      ),
    );
  }
}
