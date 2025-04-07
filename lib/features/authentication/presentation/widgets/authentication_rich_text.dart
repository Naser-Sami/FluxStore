import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import '/core/_core.dart' show BuildContextExtensions;

class AuthenticationRichTextWidget extends StatelessWidget {
  final void Function()? onTap;
  final String text1;
  final String text2;
  const AuthenticationRichTextWidget({
    super.key,
    this.onTap,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: text1.tr(),
          style: context.textTheme.titleMedium?.copyWith(),
          children: [
            TextSpan(
              text: ' ${text2.tr()}',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onSurface,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
