import 'package:flutter/material.dart';

import '/config/_config.dart' show TRadius;
import '/core/_core.dart' show BuildContextExtensions;

class ExpansionTileWidget extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget> children;
  final Widget? trailing;
  final ValueChanged<bool>? onExpansionChanged;
  final bool initiallyExpanded;
  final Color? collapsedBackgroundColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? childrenPadding;
  final bool showTrailingIcon;
  final bool? dense;

  const ExpansionTileWidget({
    super.key,
    required this.title,
    this.leading,
    this.children = const <Widget>[],
    this.trailing,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    this.collapsedBackgroundColor,
    this.backgroundColor,
    this.tilePadding,
    this.childrenPadding,
    this.showTrailingIcon = true,
    this.dense,
  });

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(TRadius.r16)),
          ),
          collapsedShape: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(TRadius.r16)),
            borderSide: BorderSide.none,
          ),
        ),
        child: ExpansionTile(
          key: key,
          title: title,
          leading: leading,
          trailing: trailing,
          dense: dense,
          showTrailingIcon: showTrailingIcon,
          onExpansionChanged: onExpansionChanged,
          initiallyExpanded: initiallyExpanded,
          collapsedBackgroundColor: collapsedBackgroundColor,
          backgroundColor: backgroundColor,
          tilePadding: tilePadding ?? EdgeInsets.zero,
          childrenPadding: childrenPadding,
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(TRadius.r16)),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(TRadius.r16)),
          ),
          children: children,
        ),
      ),
    );
  }
}
