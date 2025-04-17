import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show DiscoverCollectionBaseItem;

class DiscoverCollectionBaseExpansionTile extends StatelessWidget {
  const DiscoverCollectionBaseExpansionTile({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
          thickness: 0,
          space: 0,
        ),
      ),
      child: ExpansionTileTheme(
        data: const ExpansionTileThemeData(
          tilePadding: EdgeInsets.zero,
          shape: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(TRadius.r16)),
            borderSide: BorderSide.none,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(TRadius.r16),
          child: ExpansionTile(
            key: UniqueKey(),
            dense: true,
            showTrailingIcon: false,
            initiallyExpanded: false,
            title: const DiscoverCollectionBaseItem(),
            children: children,
          ),
        ),
      ),
    );
  }
}
