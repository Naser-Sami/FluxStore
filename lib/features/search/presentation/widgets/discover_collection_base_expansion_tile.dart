import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/_features.dart' show DiscoverCollectionBaseItem;

class DiscoverCollectionBaseExpansionTile extends StatelessWidget {
  const DiscoverCollectionBaseExpansionTile({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      key: UniqueKey(),
      initiallyExpanded: false,
      showTrailingIcon: false,
      title: const DiscoverCollectionBaseItem(),
      children: children,
    );
  }
}
