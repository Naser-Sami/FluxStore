import 'package:flutter/material.dart';

import '/features/_shared/_shared.dart' show FilterDrawerPrice;

class FilterDrawerBody extends StatelessWidget {
  const FilterDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [FilterDrawerPrice()]);
  }
}
