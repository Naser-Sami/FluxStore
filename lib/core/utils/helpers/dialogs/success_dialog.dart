import 'package:flutter/material.dart';

import '/config/_config.dart' show IconWidget, TSize, TextWidget;
import '/core/_core.dart' show LocaleKeys;

successDialog(
  BuildContext context, {
  required String message,
  required void Function()? onPressed,
  bool barrierDismissible = true,
}) {
  final theme = Theme.of(context);

  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade100,
              ),
              child: const IconWidget(
                name: 'checkmark-circle',
                width: 78,
                height: 78,
              ),
            ),
            const SizedBox(height: TSize.s12),
            TextWidget(
              LocaleKeys.Common_congratulations,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: TSize.s16),
            TextWidget(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: onPressed,
              child: const TextWidget(LocaleKeys.Common_thanks),
            ),
          ),
        ],
      );
    },
  );
}
