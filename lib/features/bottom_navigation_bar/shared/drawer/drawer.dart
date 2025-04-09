import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show DrawerCubit;
import 'widgets/_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DrawerCubit>()..loadDrawerItems(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
        child: SizedBox(
          width: context.screenWidth * 0.6,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              InfoCard(),
              Spacer(),
              DrawerSectionOne(),
              Spacer(),
              TextWidget(LocaleKeys.DrawerMenu_otherC),
              Spacer(),
              DrawerSectionTwo(),
              Spacer(flex: 2),
              ThemeButtons(),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
