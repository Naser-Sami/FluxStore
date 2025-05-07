import 'package:flutter/material.dart';

import '/config/_config.dart' show ExpansionTileWidget;
import '/features/_features.dart' show ProductsSlider;

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpansionTileWidget(
      title: Text('Similar Products'),
      initiallyExpanded: true,
      children: [ProductsSlider()],
    );
  }
}
