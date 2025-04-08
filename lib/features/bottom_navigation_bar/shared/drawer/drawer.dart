import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import 'widgets/_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
      child: SizedBox(
        width: context.screenWidth * 0.6,
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: TPadding.p32,
                  bottom: TPadding.p48,
                ),
                child: InfoCard(),
              ),
              DrawerSectionOne(),
              SizedBox(height: TPadding.p24),
              TextWidget(LocaleKeys.DrawerMenu_otherC),
              SizedBox(height: TPadding.p24),
              DrawerSectionTwo(),
              SizedBox(height: TPadding.p24),
              ThemeButtons(),
              SizedBox(height: TPadding.p42),
            ],
          ),
        ),
      ),
    );
  }
}
