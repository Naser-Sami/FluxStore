import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class AuthenticationWithSocialWidget extends StatelessWidget {
  const AuthenticationWithSocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OnTapScaler(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(TPadding.p12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: context.theme.colorScheme.secondary.withValues(
                    alpha: 0.20,
                  ),
                ),
              ),
              child: IconWidget(
                name: ImagesPath.apple,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: TSize.s20),
          OnTapScaler(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(TPadding.p12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: context.theme.colorScheme.secondary.withValues(
                    alpha: 0.20,
                  ),
                ),
              ),
              child: const IconWidget(name: ImagesPath.google),
            ),
          ),
          const SizedBox(width: TSize.s20),
          OnTapScaler(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(TPadding.p12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: context.theme.colorScheme.secondary.withValues(
                    alpha: 0.20,
                  ),
                ),
              ),
              child: const IconWidget(name: ImagesPath.facebook),
            ),
          ),
        ],
      ),
    );
  }
}
