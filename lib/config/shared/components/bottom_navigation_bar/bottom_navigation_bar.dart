import 'package:flutter/material.dart';

import '/config/_config.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  const BottomNavigationBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(TPadding.p24, 0, TPadding.p24, TPadding.p42),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(TRadius.r24)),
        child: BottomAppBar(
          height: 52,
          padding: EdgeInsets.fromLTRB(
            TPadding.p20,
            TPadding.p28,
            TPadding.p20,
            0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavigationBarIconWidget(index: 0, iconName: 'home'),
              BottomNavigationBarIconWidget(index: 1, iconName: 'search'),
              BottomNavigationBarIconWidget(index: 2, iconName: 'bag'),
              BottomNavigationBarIconWidget(index: 3, iconName: 'profile'),
            ],
          ),
        ),
      ),
    );
  }
}
