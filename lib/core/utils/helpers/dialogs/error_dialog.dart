import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart' show LocaleKeys, BuildContextExtensions;
import '/config/_config.dart' show TSize, TextWidget, TPadding;

errorDialog(BuildContext context, {required String message}) {
  final theme = Theme.of(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(TPadding.p06),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.colorScheme.error,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 54,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: TSize.s12),
            TextWidget(
              LocaleKeys.Common_error.tr(),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(LocaleKeys.Common_close.tr()),
            ),
          ),
        ],
      );
    },
  );
}
