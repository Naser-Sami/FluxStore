import 'package:flutter/material.dart';

import '/config/_config.dart' show TSize;
import '_widgets.dart';

class FilterDrawerBody extends StatelessWidget {
  const FilterDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: TSize.s40,
      children: [FilterDrawerPrice(), FilterDrawerColors()],
    );
  }
}
