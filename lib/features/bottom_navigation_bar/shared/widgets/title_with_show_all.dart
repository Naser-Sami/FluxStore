import 'package:flutter/material.dart';

import '/config/_config.dart' show OnTapScaler, TPadding, TextWidget;
import '/core/_core.dart'
    show AnimatedWidgetX, BuildContextExtensions, LocaleKeys;

class TitleWithShowAll extends StatelessWidget {
  const TitleWithShowAll({
    super.key,
    required this.title,
    required this.onShowAll,
  });
  final String title;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(title, style: context.textTheme.titleLarge),
          OnTapScaler(
            onTap: onShowAll,
            child: TextWidget(
              LocaleKeys.Common_showAll,
              style: context.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    ).scaleAnimation(scaleBegin: const Offset(1.3, 1.3));
  }
}
