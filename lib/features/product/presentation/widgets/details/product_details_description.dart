import 'package:flutter/material.dart';

import '/config/_config.dart' show ExpansionTileWidget, TextWidget;
import '/core/_core.dart' show BuildContextExtensions, LocaleKeys;

class ProductDetailsDescription extends StatelessWidget {
  final String description;

  const ProductDetailsDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      initiallyExpanded: true,
      title: const TextWidget(LocaleKeys.Product_description),
      children: [
        SizedBox(
          width: context.screenWidth,
          child: Text(description, textAlign: TextAlign.start),
        ),
      ],
    );
  }
}
