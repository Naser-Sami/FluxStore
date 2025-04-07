import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

import '/config/_config.dart' show TRadius, OnTapScaler, TPadding, TextWidget;
import '/core/_core.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(TRadius.r30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: OnTapScaler(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: TPadding.p53,
              vertical: TPadding.p15,
            ),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.grey.withValues(alpha: 0.80),
              borderRadius: BorderRadius.circular(TRadius.r30),
              border: Border.all(
                color: borderColor ?? context.theme.colorScheme.onPrimary,
                width: 2.0,
              ),
            ),
            child: TextWidget(
              text,
              style: context.textTheme.titleMedium?.copyWith(
                color: textColor ?? context.theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
